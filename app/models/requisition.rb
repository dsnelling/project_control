# Requisition model - each instance contains information about one requsition
#
# 
class Requisition < ActiveRecord::Base
  has_many :contracts
  has_many :req_comments

  named_scope :by_req, lambda {|r| {:conditions => ['req_num LIKE ?',
    r.to_s + '%'] }}
  named_scope :by_scope, lambda {|s| { :conditions => ['scope LIKE ?',
    s.to_s + '%'] }}
  named_scope :by_status, lambda {|s| {:conditions => ['status LIKE ?',
    s.to_s + '%'] }}

  REQ_TYPES = [
    ["", ""],
	["B - services","B"],
	["C - vessels","C"],
	["D - motors","D"],
	["E - exchangers","E"],
	["F - furnace parts","F"],
	["G - pumps","G"],
	["H - cranes, HVAC, civil items","H"],
	["J - instruments","J"],
	["K - compressors, fans","K"],
	["L - piping, mechanical","L"],
	["M - construction items","M"],
	["N - adsorbents, internals","N"],
	["P - electrical","P"],
	["R - provisoning, spares","R"],
	["S - steelwork","S"],
	["Q - tanks","Q"],
	["T - Technip reformer items","T"],
	["U - packaged equipment","U"],
	["W - silencer","W"]
  ]

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
