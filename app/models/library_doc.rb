class LibraryDoc < ActiveRecord::Base
  mount_uploader :document, LibraryDocUploader

  CATEGORY_TYPES = [
  # as disp,   in db
  ["Procedure","Procedure"],
  ["Form: Procurement","Form: Procurement"],
  ["Form: Other","Form: Other"],
  ["Other", "Other"]
  ]

  validates_presence_of :title, :category
  validates_inclusion_of :category, :in => CATEGORY_TYPES.map {|disp, value|
    value }

end
