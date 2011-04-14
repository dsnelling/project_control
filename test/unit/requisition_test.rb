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
	  :commodity => "some commodity")
    req.scope = "blah"
    assert !req.valid?

    req.scope = "lpec_ps"
    assert req.valid?
  end

end
