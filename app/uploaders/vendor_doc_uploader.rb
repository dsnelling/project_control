# encoding: utf-8

class VendorDocUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader
  # storage :file
  storage :s3

  # set the cache directory to a writable temp directory
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  #def store_dir
  #  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end

  # Provide a default URL as a default if there hasn't been a file uploaded
  #     def default_url
  #       "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  #     end

  # Add a white list of extensions which are allowed to be uploaded
  def extension_white_list
    %w(pdf tif tiff jpg jpeg png)
  end

  # Override the filename of the uploaded files
  def filename
    @name ||= ActiveSupport::SecureRandom.hex
    "#{@name}#{File.extname(original_filename).downcase}" if original_filename
  end

end
