# allows documents to be kept and associated with requisitions. for example
# bids, internal approval docs, etc
#
class ProcurementDoc < ActiveRecord::Base
  mount_uploader :proc_document, ProcDocumentUploader
  belongs_to :requisition

  CATEGORY_TYPES = [
    #  display name, classification, db name,
	#         (T=technical, C=commercial, U=unknown)
    ["Enquiry Application","T","EnqApp"],
	["Technical Proposal","T","TechProp"],
	["Commmercial Proposal","C","CommProp"],
	["Technical Bid Approval","T","TBAppr"],
	["Approved Commercial Bid Summary","C","CBAppr"],
	["LOI/DOA","C","LOI"],
	["Contract","C","Contract"],
	["Contract Change Order","C","Change"],
	["Meeting Minutes","T","MoM"],
	["Inspection Report","T","InspectReport"],
	["Release Note","T","ReleaseNote"],
	["Other","U","Other"]
  ]

  validates_presence_of :category, :source, :proc_document
  validates_inclusion_of :category, :in =>
     CATEGORY_TYPES.map{|disp, classif, code | code }
end
