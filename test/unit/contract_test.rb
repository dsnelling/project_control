require 'test_helper'

class ContractTest < ActiveSupport::TestCase
 test "invalid with empty attributes" do
    contract = Contract.new
	assert contract.invalid?
	assert contract.errors[:reference].any?
	assert contract.errors[:commence_date].any?
	assert contract.errors[:commodity].any?
	assert contract.errors[:supplier].any?
  end

  test "contract currency in list" do
    contract = Contract.new(:reference => "CONTRACT-1", :commence_date =>
	  "2011-06-22", :commodity => "big valves", :currency => "RMB", :supplier =>
	  "no 1 valve company", :expedite_status => "")
    contract.currency = "blah"
    assert contract.invalid?

    contract.currency = "EUR"
    assert contract.valid?
  end

  test "expedite_status in list" do
    contract = Contract.new(:reference => "CONTRACT-2", :commence_date => 
	  "2011-04-22", :supplier => "no 2 valve company",
	  :commodity => "little valves", :currency => "EUR", :expedite_status => "")
    contract.expedite_status = "blah"
    assert contract.invalid?

    contract.expedite_status = "unknown"
    assert contract.valid?
  end

  test "req_num uniqueness test" do
    contract1 = Contract.new(:reference => "CONTRACT-1", :commence_date =>
	  "2011-06-22", :commodity => "big valves", :currency => "RMB", :supplier =>
	  "no 1 valve company", :expedite_status => "")
    assert contract1.valid?
    contract1.save
  
    contract2 = Contract.new(:reference => "CONTRACT-1", :commence_date =>
	  "2011-06-23", :commodity => "big valves", :currency => "RMB", :supplier =>
	  "no 1 valve company", :expedite_status => "")

    assert contract2.invalid?

    contract2.reference = "CONTRACT-2"
    assert contract2.valid?

  end

end
