require 'test_helper'

class ProcurementDocTest < ActiveSupport::TestCase
 # not worked out how to do this as I suspect carrierwave is messing with the
 # proc_document attribute

test "invalid with empty attributes" do
    pdoc = ProcurementDoc.new
	assert !pdoc.valid?
	assert pdoc.errors.invalid?(:category)
	assert pdoc.errors.invalid?(:source)
	assert pdoc.errors.invalid?(:proc_document)
  end

=begin
  test "proc_doc category in list" do
    pdoc = ProcurementDoc.new(:requisition_id => 2, :source =>
	  "somewhere", :proc_document => "or2rdr24234", :category => "EnqApp")
    assert pdoc.valid?
	pdoc.category = "blah"
    #assert !pdoc.valid?

    pdoc.category = "InspectReport"
    #assert pdoc.valid?
  end
=end

end
