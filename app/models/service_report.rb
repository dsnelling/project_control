class ServiceReport < ActiveRecord::Base
  belongs_to :service_request
  mount_uploader :document, ServiceReportUploader
  validates :actual_cost, :numericality => true


  REPORT_STATUS_TYPES = [
    ["",               ""],
    ["Awaiting Issue","Awaiting Issue"],
    ["Pending AP","Pending AP"],
    ["CAPC Review","CAPC review"],
    ["Rejected","Rejected"],
    ["Approved","Approved"]
  ]

  validates :report_ref, :presence => true

end
