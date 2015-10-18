OmniAuth.config.logger = Rails.logger

FACEBOOK_APP_ID="947332042013704"
FACEBOOK_SECRET="2ca1ec98ce1e2e2976af76cba1f995a1"

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "947332042013704", "2ca1ec98ce1e2e2976af76cba1f995a1"
end