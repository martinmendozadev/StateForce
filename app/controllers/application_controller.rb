class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def after_sign_in_path_for(resource)
    if resource.respond_to?(:confirmed?) && !resource.confirmed?
      instructions_path
    else
      dashboard_path
    end
  end
end
