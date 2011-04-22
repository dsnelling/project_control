# tracks manhours worked at site by category
#

class SiteHour < ActiveRecord::Base
  validates_numericality_of :total_hr, :owner_hr, :epc_hr, :svision_hr,
    :only_integer => true

  # sum up to get the weekly totals before saving
  def before_validation
    self.total_hr = self.owner_hr + self.epc_hr + self.svision_hr +
	  self.constr_hr
  end

end
