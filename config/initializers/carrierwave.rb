# initializer for carrierwave
#
CarrierWave.configure do |config|
  # set S3 bucket acccess policy to only allow access from http referals
  # from this web app. set this in the S3 configuration
  #
  # "fog" only good for carrierwave 0.5+
  #config.fog_credentials = {
  #  :provider => 'AWS',
  #	:aws_access_keys_id => ENV['S3_ACCESS_KEY'],
  #  :aws_secret_access_key => ENV['S3_SECRET_KEY']
  #}
  #config.fog_directory = 'capc-project-development'
  #config.fog_public = true
  
  config.s3_access_key_id = ENV['S3_ACCESS_KEY']
  config.s3_secret_access_key = ENV['S3_SECRET_KEY']
  config.s3_bucket = ENV['S3_BUCKET_NAME']
  #config.s3_access_policy = :public_read

  #puts config.s3_access_key_id
  #puts config.s3_secret_access_key
  #puts config.s3_bucket

end

