CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    endpoint: 'http://s3.amazonaws.com'
    path_style: true
  }
  config.fog_directory = ENV["AWS_S3_BUCKET"]
  config.fog_authenticated_url_expiration = 600
  config.asset_host = "http://img.kravly.com"

  if Rails.env.test?
    config.asset_host = nil
  	config.storage = :file
    config.enable_processing = false
  elsif Rails.env.development?
    config.asset_host = nil
  	config.storage = :file
  elsif Rails.env.production?
  	config.storage = :fog
  end
end