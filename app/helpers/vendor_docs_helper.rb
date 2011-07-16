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
    bucket = s3_bucket
	folder = "uploads"
    access_key_id = s3_access_key_id
    secret_access_key = s3_secret_access_key
    expiration_date = 2.days.from_now.utc.to_i # 2 days from now in UTC epoch time (i.e. 1308172844)

    s3_key = "#{folder}/#{s3_key}"
    # this needs to be formatted exactly as shown below and UTF-8 encoded
    string_to_sign = "GET\n\n\n#{expiration_date}\n/#{bucket}/#{s3_key}"
	#.encode("UTF-8")

    # we have to CGI/URL escape the signature since it would fail if it included / or + characters
    signature = CGI.escape( Base64.encode64(
                              OpenSSL::HMAC.digest(
                                OpenSSL::Digest::Digest.new('sha1'),
                                  secret_access_key, string_to_sign)).gsub("\n","") )
  
    return "#{s3_base_url}/#{s3_key}?AWSAccessKeyId=#{access_key_id}
	&Expires=#{expiration_date}
	&Signature=#{signature}"
  end

  #---  Creates an upload link for load to S3 using PlUpload
  #
  def s3_uploader_plupload(options = {})
    
	s3_access_key_id = ENV['S3_ACCESS_KEY']
    s3_secret_access_key = ENV['S3_SECRET_KEY']
    s3_bucket = ENV['S3_BUCKET_NAME']
  
    options[:key] ||= 'test'  # folder on AWS to store file in
    options[:acl] ||= 'public-read'
    options[:expiration_date] ||= 10.hours.from_now.utc.iso8601
    options[:max_filesize] ||= 500.megabytes
    options[:filter_title] ||= 'Documents'
    options[:filter_extentions] ||= 'pdf,tif,tiff,doc,docx,xls,xlsx,jpg'

    id = options[:id] ? "_#{options[:id]}" : ''

    policy = Base64.encode64(
      "{'expiration': '#{options[:expiration_date]}',
        'conditions': [
          {'bucket': '#{s3_bucket}'},
          {'acl': '#{options[:acl]}'},
          {'success_action_status': '201'},
          ['content-length-range', 0, #{options[:max_filesize]}],
          ['starts-with', '$key', ''],
          ['starts-with', '$Filename', '']
        ]
      }").gsub(/\n|\r/, '')

    signature = Base64.encode64(
                  OpenSSL::HMAC.digest(
                    OpenSSL::Digest::Digest.new('sha1'),
                    s3_secret_access_key, policy)).gsub("\n","")
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
            $('#progress_bar').show(function () {               
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
          
          alert('There was an error.  Check the browser console log for more info');
          console.log('Expand the error object below to see the error. Use WireShark to debug.');
          
          console.log(error);
        });
      
    });")
  end  

=begin
#---  Creates an upload link to a Fancy Upload S3 File Uploader
  #
  def s3_uploader_fancyupload(options = {})
    
	s3_access_key_id = ENV['S3_ACCESS_KEY']
    s3_secret_access_key = ENV['S3_SECRET_KEY']
    s3_bucket = ENV['S3_BUCKET_NAME']
  

    options[:key] ||= 'test'  # folder on AWS to store file in
    options[:acl] ||= 'public-read'
    options[:expiration_date] ||= 10.hours.from_now.utc.iso8601
    options[:max_filesize] ||= 500.megabytes
    options[:filter_title] ||= 'Documents'
    options[:filter_extentions] ||= 'pdf,tif,tiff,doc,docx,xls,xlsx'

    id = options[:id] ? "_#{options[:id]}" : ''

    policy = Base64.encode64(
      "{'expiration': '#{options[:expiration_date]}',
        'conditions': [
          {'bucket': '#{s3_bucket}'},
          {'acl': '#{options[:acl]}'},
          {'success_action_status': '201'},
          ['content-length-range', 0, #{options[:max_filesize]}],
          ['starts-with', '$key', ''],
          ['starts-with', '$Filename', '']
        ]
      }").gsub(/\n|\r/, '')

    signature = Base64.encode64(
                  OpenSSL::HMAC.digest(
                    OpenSSL::Digest::Digest.new('sha1'),
                    s3_secret_access_key, policy)).gsub("\n","")

    out = ""
    out << "\n"
    out << link_to('Choose File','#', :id => "upload_link#{id}",
	  :class => 'medium silver button ram')
    out << "\n"
    out << content_tag(:ul, '', :id => "uploader_file_list#{id}",
	  :class => 'uploader_file_list' )
    out << "\n"
    out << javascript_tag("window.addEvent('domready', function() {
       /**
       * Uploader instance
       */
      var up#{id} = new FancyUpload3.S3Uploader( 'uploader_file_list#{id}', '#upload_link#{id}', {
		    host: '#{request.host_with_port}',
            bucket: '#{s3_bucket}',
            typeFilter: #{options[:type_filter] ? "{" + options[:type_filter] + "}" : 'null' },
            fileSizeMax: #{options[:max_filesize]},
            access_key_id: '#{s3_access_key_id}',
            policy: '#{policy}' ,
            signature: '#{signature}',
            key: '#{options[:key]}',
            id: '#{id}',
            acl: '#{options[:acl]}',
            https: #{options[:https] ? 'true' : 'false'},
            validateFileNamesURL: '#{options[:validate_filenames_url]}', 
            onUploadCompleteURL: '#{options[:on_complete_url]}',
            onUploadCompleteMethod: '#{options[:on_complete_method]}',
            formAuthenticityToken: '#{form_authenticity_token}',
            verbose: #{options[:verbose] ? 'true' : 'false' }
      })
    });")

  end
=end

end

