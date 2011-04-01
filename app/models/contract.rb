# hold supply contract (aka PO) information. On instance/record per contract
# linked to requsition (one requisition can have many contracts)
#
class Contract < ActiveRecord::Base
  belongs_to :requisition

  EXPEDITE_STATUS_TYPES = [
    ["",  ""],
	["Awaiting Expediting","unknown"],
	["Supplier reports on-track","on-track"],
	["Awaiting Payment","payment"],
	["Awaiting Documents","documents"],
	["Awaiting Materials","materials"],
	["Awaiting Free-issues","free-issues"],
	["Supplier Late","late"],
	["Late, but under control","Late-under control"],
	["late, not in control","not in control"],
	["Released","released"]
  ]	
  CURRENCY_TYPES = [
    ["",""],
    ["RMB","RMB"],
	["EUR","EUR"],
	["USD","USD"]
  ]

  validates_presence_of :commodity, :reference, :commence_date, :supplier
  validates_uniqueness_of :reference
  validates_inclusion_of :expedite_status,
    :in => EXPEDITE_STATUS_TYPES.map {|disp, value| value}
  validates_inclusion_of :currency,
    :in => CURRENCY_TYPES.map {|disp, value| value}


end
