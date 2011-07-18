class ServiceRequest < ActiveRecord::Base
  validates_presence_of :project, :request_ref, :description, :category
  validates_length_of :request_ref, :description, :minimum => 5
   scope :by_project, lambda {|p| {:conditions => ['project LIKE ?',
    p.to_s + '%'] }}

  CATEGORY_TYPES = [
    ["Engineering","A21"],
    ["Procurement","A22"],
    ["Construction","A24"],
    ["Comissioning","A25"],
    ["Operation","A31"],
    ["Materails Mgt","A32"],
    ["Other","A36"]
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
