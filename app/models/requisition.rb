# Requisition model - each instance contains information about one requsition
#
# 
class Requisition < ActiveRecord::Base
  has_many :contracts
  has_many :req_comments

  STATUS_TYPES = [
   #as displayed      in db
    ["",               ""],
	["Enquiry Issued", "enquiry"],
	["Bid Review",     "bid_review"],
	["Negotiation",    "neg"],
	["LOI placed",     "LOI"],
	["PO placed",      "PO"]
  ]

  SCOPE_TYPES = [
    ["",       ""],
	["JV Own Purchase","JV"],
	["Technip PS","technip_ps"],
	["LPEC PS","lpec_ps"],
	["LPEC EPC","lpec_epc"]
  ]


  validates_presence_of :req_num, :project
  validates_uniqueness_of :req_num
  validates_presence_of :commodity
  validates_inclusion_of :scope, :in => SCOPE_TYPES.map {|disp, value| value}
  validates_inclusion_of :status, :in => STATUS_TYPES.map {|disp, value| value}


end
