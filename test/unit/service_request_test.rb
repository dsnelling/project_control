require 'test_helper'

class ServiceRequestTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "service_request attributes must not be empty" do
    service_request = ServiceRequest.new
    assert service_request.invalid?
    assert service_request.errors[:project].any?
    assert service_request.errors[:request_ref].any?
    assert service_request.errors[:description].any?
    assert service_request.errors[:category].any?
  end

  test "service_request certain attributes must be length > 5" do
    service_request = ServiceRequest.new(:request_ref => "ho",
      :description => "ha", :project => "HYACO", :category => "blah")
    assert service_request.invalid?
    assert service_request.errors[:request_ref].any?
    assert service_request.errors[:description].any?
  end

end
