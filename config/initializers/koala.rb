Koala.configure do |config|
  config.access_token = Rails.application.secrets.facebook_access_token
  config.app_id = Rails.application.secrets.facebook_app_id
  config.app_secret = Rails.application.secrets.facebook_app_secret
end