require 'omniauth-google-oauth2'

# Internal: Initializes Google Omniauth with client_id and client_secret

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], { access_type: "offline", approval_prompt: "" }
end

