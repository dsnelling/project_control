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


