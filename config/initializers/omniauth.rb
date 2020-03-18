Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google, ENV['GOOGLE_ID'], ENV['GOOGLE_SECRET']
end