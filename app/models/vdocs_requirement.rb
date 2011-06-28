# required vendor (or supplier) documents
# one list for each contract
#
class VdocsRequirement < ActiveRecord::Base
  belongs_to :contract
  has_many :vendor_docs

  PURPOSE_TYPES = [
    ["For Approval","A"],
	["For Reference","R"]
  ]

  validates_presence_of :code, :description
  validates_inclusion_of :purpose, :in => PURPOSE_TYPES.map {|disp, value| value}

end

=begin

  SCOPE_TYPES = [
    ["",       ""],
	["JV Own Purchase","JV"],
	["Technip PS","technip_ps"],
	["LPEC PS","lpec_ps"],
	["LPEC EPC","lpec_epc"],
	["CTIEI Open Item","ctiei_open"],
	["CTIEI Closed Item","ctiei_closed"]
  ]


  validates_presence_of :req_num, :project
  validates_uniqueness_of :req_num, :scope => "project"
  validates_presence_of :commodity
  validates_inclusion_of :scope, :in => SCOPE_TYPES.map {|disp, value| value}
  validates_inclusion_of :status, :in => STATUS_TYPES.map {|disp, value| value}

=end
