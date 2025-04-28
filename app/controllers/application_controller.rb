class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :ensure_email_confirmed, if: :user_signed_in?, unless: -> { request.path == users_instructions_path }

  protected

  def after_sign_in_path_for(resource)
    if resource.confirmed?
      dashboard_path
    else
      users_instructions_path
    end
  end

  private

  def ensure_email_confirmed
    unless current_user.confirmed?
      redirect_to users_instructions_path, alert: t("devise.failure.unconfirmed")
    end
  end
end
