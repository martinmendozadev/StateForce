class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def authenticate_confirmed_user!
    authenticate_user!

    return unless user_signed_in?

    unless current_user.confirmed?
      sign_out(current_user)
      redirect_to users_instructions_path, alert: t("devise.confirmations.send_instructions")
    end
  end

  def after_sign_in_path_for(resource)
    if resource.confirmed?
      dashboard_path
    else
      sign_out(resource)
      users_instructions_path
    end
  end
end
