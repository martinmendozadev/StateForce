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
			["pages", "landing"],
			["pages", "learn_more"],
			["pages", "color_palette"],
		]

		controller_action = [controller_name, action_name]
		public_routes.include?(controller_action)
	end
end
