# initializer for carrierwave
#
CarrierWave.configure do |config|
  # set S3 bucket acccess policy to only allow access from http referals
  # from this web app. set this in the S3 configuration
  #
  # some issues found with carrierwave/S3
  #  - "fog" only good for carrierwave 0.5+, which is for Rails 3.
  #  - the S3 authenticated URL does not seem to be available, so will have to
  #    rely on less secure methods. strategy is to use random filenames,
  #    and S3 bucket access control to referrers from this website only
  #  - didn't work for bucket locations outside the US, but might
  #    if the access style is the subdomain style (not sure the offical name).
  #  - will have to test to see if the asian buckets have an advantage. they 
  #    should do as its a write once and read many situation.
  #  - specifying the access policy here seem to be a problem (althought it
  #    may have been something else causing the problem). 
  #
  
  config.s3_access_key_id = ENV['S3_ACCESS_KEY']
  config.s3_secret_access_key = ENV['S3_SECRET_KEY']
  config.s3_bucket = ENV['S3_BUCKET_NAME']
  #config.s3_access_policy = :public_read

  #puts config.s3_access_key_id
  #puts config.s3_secret_access_key
  #puts config.s3_bucket

end

