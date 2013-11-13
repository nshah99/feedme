CarrierWave.configure do |config|
  
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    #:region => ENV['S3_REGION']
  }
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :fog
  end

  
  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku
  config.fog_directory = ENV['S3_BUCKET_NAME']

end  
