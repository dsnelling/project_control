class VendorDoc < ActiveRecord::Base
  #  uses fancyuploader rather than carrierwave, so uploading is client 
  #  directly to S3, bypassing rails

  belongs_to :vdocs_requirement

  STATUS_TYPES = [
    ["Code 1: Resubmit","1"],
	["Code 2: Approved as noted, Resubmit","2"],
	["Code 3: Approved as noted","3"],
	["Code 4: Approved", "4"],
	["Accepeted for Information","5"]
  ]

  validates_presence_of :doc_number, :title
  validates_inclusion_of :doc_status, :in => STATUS_TYPES.map {|disp, value| value}

end
