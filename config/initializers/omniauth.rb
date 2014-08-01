require 'omniauth-google-oauth2'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "911135299478-su1ivmh1ul0ellg6pkvd76id8va257dm.apps.googleusercontent.com", "qM9behImaTxyPlEW6aJ1Rsep", { access_type: "offline", approval_prompt: "" }
end
