class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  enum :role, guest: 0, standard: 1, admin: 2

  # Ensure password is required only when setting or updating it, and skip for provider-based users
  validates :password, presence: true, if: -> { new_record? || (password.present? && provider.blank?) }, unless: -> { provider.present? && uid.present? }

  def password_required?
    provider.blank? && uid.blank? && super
  end

  def active_for_authentication?
    super || !confirmed?
  end

  def inactive_message
    confirmed? ? super : :unconfirmed
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.avatar_url = auth.info.image
      user.confirmed_at = Time.current
    end
  end
end
