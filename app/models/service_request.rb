class ServiceRequest < ActiveRecord::Base
  has_many :service_reports #, :dependant => :delete_all
  mount_uploader :service_request_doc, ServiceRequestDocUploader

  validates_presence_of :project, :request_ref, :description, :category
  validates_length_of :request_ref, :description, :minimum => 5
  validates :auth_cost, :numericality => true
  scope :by_project, lambda {|p| {:conditions => ['project LIKE ?',
    p.to_s + '%'] }}

  CATEGORY_TYPES = [
    ["",""],
    ["Project Team Labour","A21"],
    ["Project Team T&L: local","A22"],
    ["Project Team T&L: overseas","A23"],
    ["Engineering Support","A51"],
    ["Procurement Support","A52"],
    ["Construction Support","A53"],
    ["Commissioning Support","A54"],
    ["Operation","A56"],
    ["Materails Mgt","A57"],
    ["Other","A55"],
    ["SAP Support","SAP"]
  ]

  STATUS_TYPES = [
   #as displayed      in db
    ["",               ""],
    ["Awaiting Issue","Awaiting Issue"],
    ["Pending AP","Pending AP"],
    ["CAPC Review","CAPC review"],
    ["Rejected","Rejected"],
    ["Approved","Approved"]
  ]

  validates_inclusion_of :category,
    :in => CATEGORY_TYPES.map {|disp, value| value}


end
