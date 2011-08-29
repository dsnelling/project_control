// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//

//--- datepicker
$.datepicker.setDefaults({
   dateFormat: 'yy-mm-dd',
   firstDay: 1
});

$(function() {
  $("#service_request_request_date").datepicker();
  $("#service_request_auth_date").datepicker();
  $("#site_hour_week_start").datepicker();
  $("#incident_incident_date").datepicker();
  $("#requisition_required_on_site").datepicker();
  $("#requisition_required_contract").datepicker();
  $("#requisition_bid_applic_approved").datepicker();
  $("#requisition_enquiry_issued").datepicker();
  $("#requisition_tbt_issued").datepicker();
  $("#requisition_cbt_issued").datepicker();
  $("#contract_commence_date").datepicker();
  $("#contract_delivery_date_contract").datepicker();
  $("#contract_delivery_date_forecast").datepicker();
  $("#contract_expedite_last_contact").datepicker();
  $("#vdocs_requirement_due_date").datepicker();
  $("#vendor_doc_date_received").datepicker();

});

// plupload -- from github.com/lgs/mp3upload
$(function() {
  var uploader = new plupload.Uploader({
    runtimes : 'gears,html5,flash,silverlight',
	browse_button : 'pickfiles',
	container : 'container',
	max_file_size : '10mb',
	url : '/',
	flash_swf_url : '/javascripts/plupload.flash.swf',
	silverlight_xap_url : '/javascripts/plupload.silverlight.xap',
	filters : {
	  title : "Documents", extensions : "pdf,tif"
	},
	multipart: true
	multipart_params: {
	  "authenticity_token" : '<%= form_authenticity_token %>'
	}
  });

  uploader.bind('BeforeUpload', function(up, files) {
    $.extend(up.settings.multipart_params, { title : $('#title').val() });
  });

  uploader.bind('FilesAdded'), function(up, files) {
    $.each(files, function(i, file) {
	  $('#documentlist').append(
	    '<div id="' + file.id + '">' +
		'File: ' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
		'</div>'
		);
	  $('#documentlist').css("color","red");
	});
  });

  uploader.bind('UploadProgress', function(up, file) {
    $('#' + file.id + " b").html(file.percent + "%");
  });

  uploader.bind('Error', function(up, err) {
    $('#filelist').append("<div>Error: " + err.code +
	  ", Message: " +err.message + 
	  (err.file ? ", File: " + err.file.name : "") +
	  "</div>");
  });

  uploader.bind('FileUploaded', function(up, file) {
    $('#' + file.id + " b").html("100%");
  });

  $('#uploadfiles').click(function(e) {
    uploader.start();
	e.preventDefault();
  });

  uploader.init();
});

