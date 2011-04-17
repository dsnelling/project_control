class ServiceRequest < ActiveRecord::Base
  validates_presence_of :project, :request_ref, :description
  validates_length_of :request_ref, :description, :minimum => 5

  named_scope :by_project, lambda {|p| {:conditions => ['project LIKE ?',
    p.to_s + '%'] }}

  STATUS_TYPES = [
   #as displayed      in db
    ["",               ""],
    ["Awaiting Issue","Awaiting Issue"],
    ["Pending AP","Pending AP"],
	["CAPC Review","CAPC review"],
	["Rejected","Rejected"],
	["Approved","Approved"]
  ]

end
