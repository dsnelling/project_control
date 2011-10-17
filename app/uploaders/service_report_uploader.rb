# encoding: utf-8

class ServiceReportUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader
  storage :fog

  # set cache directory to writable temp directory (for Heroku)
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  #def store_dir
  #  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end

  # Add a white list of extensions which are allowed to be uploaded,
  def extension_white_list
    %w(pdf)
  end

  # Override the filename of the uploaded files
  def filename
    @name ||= ActiveSupport::SecureRandom.hex
	"#{@name}#{File.extname(original_filename).downcase}" if original_filename
  end

end
