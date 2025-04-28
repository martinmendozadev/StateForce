class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def authenticate_user!(*args)
    super(*args)
    return unless user_signed_in?

    if user_signed_in? && !current_user.confirmed? && !devise_controller? && request.path != users_instructions_path
      redirect_to users_instructions_path, alert: t("devise.failure.unconfirmed")
    end
  end

  def after_sign_in_path_for(resource)
    resource.confirmed? ? dashboard_path : users_instructions_path
  end
end
