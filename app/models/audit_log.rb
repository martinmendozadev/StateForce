# frozen_string_literal: true

class AuditLog < ApplicationRecord
  include Enums
  # Associations
  belongs_to :user, optional: true


  # Enums
  enum :action, ACTIONS, prefix: true
  enum :entity_name, ENTITY_NAMES, prefix: true


  # Validations
  validate :validate_json_fields
  validates :new_value, presence: true
  validates :action, presence: true, inclusion: { in: actions.keys }
  validates :entity_name, presence: true, inclusion: { in: entity_names.keys }
  validates :entity_id,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }


  private

  def validate_json_fields
    errors.add(:new_value, I18n.t("audit_log.models.errors.messages.invalid_json_object")) unless new_value.is_a?(Hash)
    errors.add(:old_value, I18n.t("audit_log.models.errors.messages.invalid_json_object")) if old_value.present? && !old_value.is_a?(Hash)
  end
end
