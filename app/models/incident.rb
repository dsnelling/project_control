# Incident - tracks safety incidents. Allows report document to be uploaded
#   (using Carrierwave)
#
class Incident < ActiveRecord::Base
  mount_uploader :incident_report, IncidentReportUploader

  CATEGORY_TYPES = [
    # as-disp , in-db  
    ["APT","APT"],
	["Near Miss","Near Miss"],
	["First Aid","First Aid"],
	["Recordable","Recordable"],
	["Lost Time","Lost Time"],
	["Fatality","Fatality"]
  ]
  
  validates_presence_of :project, :reference, :category, :title, :incident_date
  validates_uniqueness_of :reference, :scope => "project"
  validates_inclusion_of :category, :in => 
    CATEGORY_TYPES.map {|disp, value| value} 

 

end
