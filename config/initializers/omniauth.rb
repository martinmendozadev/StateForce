# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV["GOOGLE_OAUTH_CLIENT_ID"],
           ENV["GOOGLE_OAUTH_CLIENT_SECRET"],
           { scope: "email, profile",
             access_type: "offline",
             prompt: "select_account" }
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.allowed_request_methods = %i[get post]
