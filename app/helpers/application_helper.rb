module ApplicationHelper
  # Returns true when the base layout (sidebar/topbar, etc.) should be shown.
  # Show only for logged-in users on non-public pages.
  def show_base_layout?
    user_signed_in? && !public_path?
  end

  # Define which paths are considered public.
  # Prefer controller/action checks to avoid hardcoding URLs.
  def public_path?
    public_routes = [
      [ "pages", "landing" ],
      [ "pages", "learn_more" ],
      [ "pages", "color_palette" ]
    ]

    controller_action = [ controller_name, action_name ]
    public_routes.include?(controller_action)
  end

  def formatted_time_ago(resource_time, fallback_translation)
    if resource_time.nil?
      t(fallback_translation)
    else
      "#{time_ago_in_words(resource_time, include_seconds: true)} #{t('helpers.application.ago')}"
    end
  end

  def last_update(resource)
    formatted_time_ago(resource.updated_at, "helpers.application.never_updated")
  end

  def created_at(resource)
    formatted_time_ago(resource.created_at, "helpers.application.not_available")
  end
end
