# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]


  # Associations
  belongs_to :avatar, class_name: "Attachment", optional: true

  has_many :notes, through: :user_notes
  has_many :user_notes, dependent: :destroy
  has_many :note_editors, dependent: :destroy
  has_many :contacts, through: :user_contacts
  has_many :user_contacts, dependent: :destroy
  has_many :edited_notes, through: :note_editors, source: :note
  has_many :assigned_event_resources, class_name: "EventResource", foreign_key: "assigned_by_user_id", dependent: :destroy

  # Enums
  enum :provider, google_oauth2: 0

  # Validations
  validates :email,
            presence: true,
            length: { maximum: 150 },
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :name, length: { maximum: 75 }, allow_blank: true
  validates :uid, presence: true, if: -> { provider.present? }
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
    user = where(email: auth.info.email).first_or_create do |u|
      u.uid = auth.uid
      u.name = auth.info.name
      u.email = auth.info.email
      u.provider = auth.provider
      u.confirmed_at = Time.current
      u.password = Devise.friendly_token[0, 20]
    end

    image_url = auth.info.image.presence

    if image_url.present?
      begin
        if user.avatar.present? && user.avatar.file_url != image_url
          user.avatar.update(
            file_url: image_url,
          )
        else
          attachment = Attachment.create(
            attachable_type: "User",
            attachable_id: user.id,
            content_type: "image/jpeg",
            file_name: "avatar_#{user.id}.jpg",
            file_url: image_url,
            file_size: 1,
            uploader_user_id: user.id
          )
          user.update(avatar: attachment)
        end

      rescue StandardError
       # silently ignore avatar persistence issues to not break login
       Rails.logger.warn("Avatar persistence failed for user #{user.id}")
      end
    end

    user
  end
end
