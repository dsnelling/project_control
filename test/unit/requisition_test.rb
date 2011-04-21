require 'test_helper'

class RequisitionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    req = Requisition.new
	assert !req.valid?
	assert req.errors.invalid?(:req_num)
	assert req.errors.invalid?(:project)
	assert req.errors.invalid?(:commodity)
  end

  test "req scope in list" do
    req = Requisition.new(:req_num => "X34",:project => "my project",
	  :commodity => "some commodity", :scope => "JV", :status => "enquiry")
    req.scope = "blah"
    assert !req.valid?

    req.scope = "lpec_ps"
    assert req.valid?
  end

  test "req status in list" do
    req = Requisition.new(:req_num => "X34",:project => "my project",
	  :commodity => "some commodity", :scope => "JV", :status => "enquiry")
    req.status = "blah"
    assert !req.valid?

    req.status = "LOI"
    assert req.valid?
  end

  test "req_num uniqueness test" do
    req1 = Requisition.new(:req_num => "X35",:project => "my project",
	  :commodity => "some commodity", :scope => "JV", :status => "enquiry")
    req1.save
    req2 = Requisition.new(:req_num => "X35",:project => "my project",
	  :commodity => "some commodity", :scope => "JV", :status => "enquiry")
    assert !req2.valid?

	req2.project = "your project"
	assert req2.valid?

  end

end
