class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]


  ## Relationships
  belongs_to :avatar, class_name: "Attachment", optional: true

  has_many :assigned_event_resources, class_name: "EventResource", foreign_key: "assigned_by_user_id"

  has_many :user_contacts, dependent: :destroy
  has_many :contacts, through: :user_contacts

  has_many :user_notes, dependent: :destroy
  has_many :notes, through: :user_notes

  ## Enums
  enum :provider, google_oauth2: 0

  ## Validations
  validates :email, presence: true, length: { maximum: 150 }, uniqueness: true
  validates :name,  length: { maximum: 75 }, allow_blank: true
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
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Time.current
    end
  end
end
