# initializer for carrierwave
#
# updated to use fog (rails-3; carrierwave-0.5) DS jul-11
#
CarrierWave.configure do |config|
  #
  # some issues found with carrierwave/S3 [DS]
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
  
  config.fog_credentials = {
    :provider => 'AWS',
	:aws_access_key_id => ENV['S3_ACCESS_KEY'],
	:aws_secret_access_key => ENV['S3_ACCESS_KEY'],
	:region => 'us-west-1'   # need to check
	}
  config.fog_directory = ENV['S3_BUCKET_NAME']
  config.fog_public = 'false'
  config.fog_authenticated_url_expiration = 600  # time in seconds

end
  
  #config.s3_access_key_id = ENV['S3_ACCESS_KEY']
  #config.s3_secret_access_key = ENV['S3_SECRET_KEY']
  #config.s3_bucket = ENV['S3_BUCKET_NAME']
  #config.s3_access_policy = :public_read


