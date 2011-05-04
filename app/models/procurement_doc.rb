# allows documents to be kept and associated with requisitions. for example
# bids, internal approval docs, etc
#
class ProcurementDoc < ActiveRecord::Base
  mount_uploader :proc_document, ProcDocumentUploader
  belongs_to :requisition

  CATEGORY_TYPES = [
    ["Enquiry Application","EnquiryApplic"],
	["TechProposal","Technical Proposal"],
	["CommProposal","Commercial Proposal"],
	["TechBidApproval","Technical Bid Approval"],
	["CommBidApproval","Commercial Bid Approval"],
	["LOI","LOI/DOA"],
	["Contract","Supply Contract"],
	["MoM","Supplier Meeting Minutes"],
	["InspectReport","Inspection Report"],
	["Release","Release Note"]
  ]

  validates_presence_of :category, :source, :proc_document
  validates_inclusion_of :category, :in =>
     CATEGORY_TYPES.map{|disp, value| value }
end
