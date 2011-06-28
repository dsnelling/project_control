class VendorDoc < ActiveRecord::Base
  mount_uploader :document, VendorDocUploader
  belongs_to :vdocs_requirement

  STATUS_TYPES = [
    ["Code 1: Reject","1"],
	["Code 2: Acceptable as commented","2"],
	["Code 3: Accepted","3"]
  ]

  validates_presence_of :doc_number, :title
  validates_inclusion_of :doc_status, :in => STATUS_TYPES.map {|disp, value| value}

end
