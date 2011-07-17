# tracks manhours worked at site by category
#

class SiteHour < ActiveRecord::Base
  validates_numericality_of :total_hr, :owner_hr, :epc_hr, :svision_hr,
    :only_integer => true
  validates_presence_of :week_start, :total_hr, :owner_hr, :epc_hr, :svision_hr

  before_validation :sum_totals

  private
    # sum up to get the weekly totals before saving
    def sum_totals
      self.total_hr = self.owner_hr.to_i + self.epc_hr.to_i +
	    self.svision_hr.to_i + self.constr_hr.to_i
    end

end
