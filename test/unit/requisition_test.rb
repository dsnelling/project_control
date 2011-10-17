require 'test_helper'

class RequisitionTest < ActiveSupport::TestCase
  fixtures :requisitions

  test "invalid with empty attributes" do
    req = Requisition.new
	assert req.invalid?
	assert req.errors[:req_num].any?
	assert req.errors[:project].any?
	assert req.errors[:commodity].any?
  end

  test "req scope in list" do
    req = Requisition.new(:req_num => "X34",:project => "my project",
	  :commodity => "some commodity", :scope => "JV", :status => "enquiry")
    req.scope = "blah"
    assert req.invalid?

    req.scope = "lpec_ps"
    assert req.valid?
  end

  test "req status in list" do
    req = Requisition.new(:req_num => "X34",:project => "my project",
	  :commodity => "some commodity", :scope => "JV", :status => "enquiry")
    req.status = "blah"
    assert req.invalid?

    req.status = "LOI"
    assert req.valid?
  end

  test "req_num uniqueness test" do
    req1 = Requisition.new(:req_num => "X35",:project => "my project",
	  :commodity => "some commodity", :scope => "JV", :status => "enquiry")
    req1.save
    req2 = Requisition.new(:req_num => "X35",:project => "my project",
	  :commodity => "some commodity", :scope => "JV", :status => "enquiry")
    assert req2.invalid?

    req2.project = "your project"
    assert req2.valid?

  end

end
