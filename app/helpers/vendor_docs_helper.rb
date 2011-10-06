module VendorDocsHelper

  def display_status(code)
    d = VendorDoc::STATUS_TYPES.detect{|descrip, c| c ==
	  code}
	# if the code is not in the array, return the code
	d ? d.first : code
  end

  def display_icon(url)
    #selects the correct icon to display based on the file type of the url
	ext=url.split('.').last if url
    case ext
	  when "pdf" then image_tag("pdficon_large.gif")
	  when "xls", "xlsx" then image_tag("xlsicon_large.png")
	  when "jpg" then image_tag("jpgicon_large.png")
	  when "doc", "docx" then image_tag("docicon_large.png")
	  else
	    image_tag("attachment.gif")
	end
  end

 def generate_secure_s3_url(s3_key)
    #
    # s3_key would be a path (including filename) to the file like:
	# "folder/subfolder/filename.jpg"
    # but it should NOT contain the bucket name or a leading forward-slash
    #
    # this was built using these instructions:
    # http://docs.amazonwebservices.com/AmazonS3/latest/dev/index.html?S3_QSAuth.html
    # http://aws.amazon.com/code/199?_encoding=UTF8&jiveRedirect=1
    s3_access_key_id = ENV['S3_ACCESS_KEY']
    s3_secret_access_key = ENV['S3_SECRET_KEY']
    s3_bucket = ENV['S3_BUCKET_NAME']
  
    s3_base_url = "https://#{s3_bucket}.s3.amazonaws.com"
    expiration_date = 2.days.from_now.utc.to_i # 2 days from now in UTC epoch time
       # (i.e. 1308172844)

    # this needs to be formatted exactly as shown below and UTF-8 encoded
    string_to_sign = "GET\n\n\n#{expiration_date}\n/#{s3_bucket}/#{s3_key}"
      # .encode("UTF-8")

    # we have to CGI/URL escape the signature since it would fail if it
    # included / or + characters
    signature = CGI.escape( Base64.encode64(
                              OpenSSL::HMAC.digest(
                                OpenSSL::Digest::Digest.new('sha1'),
                                  s3_secret_access_key, string_to_sign)).gsub("\n","") )
  
    return "#{s3_base_url}/#{s3_key}?AWSAccessKeyId=#{s3_access_key_id}" +
      "&Expires=#{expiration_date}&Signature=#{signature}"
  end

  #---  Creates an upload link for load to S3 using Plupload
  #  based on https://github.com/iwasrobbed/Rails3-S3-Uploader-Plupload
  #
  def s3_uploader(options = {})
    s3_access_key_id = ENV['S3_ACCESS_KEY']
    s3_secret_access_key = ENV['S3_SECRET_KEY']
    s3_bucket = ENV['S3_BUCKET_NAME']
  
    options[:key] ||= 'test'  # folder on AWS to store file in
    options[:acl] ||= 'private'
    options[:expiration_date] ||= 10.hours.from_now.utc.iso8601
    options[:max_filesize] ||= 500.megabytes
    options[:content_type] ||= 'binary/octet-stream'
    options[:filter_title] ||= 'Documents'
    options[:filter_extentions] ||= 'pdf'

    id = options[:id] ? "_#{options[:id]}" : ''

    policy = Base64.encode64(
      "{'expiration': '#{options[:expiration_date]}',
        'conditions': [
          {'bucket': '#{s3_bucket}'},
          {'acl': '#{options[:acl]}'},
          {'success_action_status': '201'},
          ['content-length-range', 0, #{options[:max_filesize]}],
          ['starts-with', '$key', ''],
          ['starts-with', '$Content-Type', ''],
          ['starts-with', '$name', ''],
          ['starts-with', '$Filename', '']
        ]
       }").gsub(/\n|\r/, '')

    signature = Base64.encode64(
                  OpenSSL::HMAC.digest(
                    OpenSSL::Digest::Digest.new('sha1'),
                    s3_secret_access_key, policy)).gsub("\n","")
    unique_filename = ActiveSupport::SecureRandom.hex


    out = ""

    out << javascript_tag("$(function() {

      /*
       * S3 Uploader instance
       */
     // image uploader via plupload
     var uploader = new plupload.Uploader({
       runtimes : 'flash,silverlight',
       browse_button : 'pickfiles',
       max_file_size : '500mb',
       url : 'http://#{s3_bucket}.s3.amazonaws.com/',
       flash_swf_url: '/javascripts/plupload/plupload.flash.swf',
       silverlight_xap_url: '/javascripts/plupload/plupload.silverlight.xap',
       preinit : {
         UploadFile: function(up, file) {
           up.settings.multipart_params.key = '#{options[:key]}/#{unique_filename}_blah.pdf'
         }
       },
       init : {
         FilesAdded: function(up, files) {
           plupload.each(files, function(file) {
             if (up.files.length > 1) {
               up.removeFile(file);
             }
           });
           if (up.files.length >= 1) {
             $('#pickfiles').fadeOut('slow');
           }
         },
         FilesRemoved: function(up, files) {
           if (up.files.length < 1) {
             $('#pickfiles').fadeIn('slow');
           }
         }
       },
       multi_selection: false,
       multipart: true,
       multipart_params: {
         'key': 'test/${filename}',
         'Filename': '${filename}', // adding this to keep consistency across the runtimes
         'acl': '#{options[:acl]}',
         'Content-Type': '#{options[:content_type]}',
         'success_action_status': '201',
         'AWSAccessKeyId' : '#{s3_access_key_id}',
         'policy': '#{policy}',
         'signature': '#{signature}'
       },
        filters : [
          {title : '#{options[:filter_title]}', extensions : '#{options[:filter_extentions]}'}
        ],
        file_data_name: 'file'
    });

    // instantiates the uploader
    uploader.init();

    // shows the progress bar and kicks off uploading
    uploader.bind('FilesAdded', function(up, files) {
      $('#progress_bar .ui-progress').css('width', '5%');
      $('span.ui-label').show();
      // start the uploader after the progress bar shows
      $('#progress_bar').show('fast', function () {
        uploader.start();
      });
    });

    // binds progress to progress bar
    uploader.bind('UploadProgress', function(up, file) {
      if(file.percent < 100){
        $('#progress_bar .ui-progress').css('width', file.percent+'%');
      }
      else {
        $('#progress_bar .ui-progress').css('width', '100%');
        $('span.ui-label').text('Complete');
      }
    });

    // shows error object in the browser console (for now)
    uploader.bind('Error', function(up, error) {
      // unfortunately PLUpload gives some extremely vague
      // Flash error messages so you have to use WireShark
      // for debugging them (read the README)
      alert('There was an error. Check the browser console log for more info');
      console.log('Expand the error object below to see the error. Use WireShark to debug.');
      console.log(error);
    });

    // Update input field in form with filename.
    uploader.bind('FileUploaded', function(up, file, info){
      $('#vendor_doc_document').attr('value',up.settings.multipart_params.key);
      $('#vendor_doc_submit').show()

    });

  });")
  
  end

end

