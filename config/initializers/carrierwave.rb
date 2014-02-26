CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
  }
  config.fog_directory = ENV["AWS_S3_BUCKET"]
  config.fog_authenticated_url_expiration = 600

  if Rails.env.test?
  	config.storage = :file
    config.enable_processing = false
  elsif Rails.env.development?
  	config.storage = :file
  elsif Rails.env.production?
  	config.storage = :fog
  end
end