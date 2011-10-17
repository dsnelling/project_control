require 'test_helper'

class ServiceReportsControllerTest < ActionController::TestCase
  setup do
    @service_report = service_reports(:one)
    @service_request = service_requests(:one)
    @service_request.service_reports << @service_report
  end

  #test "without valid service_request_id" do
  #  get :show, {:id => @service_report.to_param, :service_request_id => "3"}
  #  assert_redirected_to service_request_url
  #end

  test "should get new" do
    get(:new, {:service_request_id => @service_request})
    assert_response :success
  end

  test "should create service_report" do
    assert_difference('ServiceReport.count') do
      post :create, {:service_report => @service_report.attributes,
        :service_request_id => @service_request }
    end

    assert_redirected_to \
      service_request_path(assigns(:service_report).service_request,
      :notice => 'Service report was successfully created.')
  end

  test "should show service_report" do
    get :show, {:id => @service_report.to_param,
      :service_request_id => @service_request }
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => @service_report.to_param,
      :service_request_id => @service_request}
    assert_response :success
  end

  test "should update service_report" do
    put :update, :id => @service_report.to_param,
      :service_request_id => @service_request.to_param,
      :service_report => @service_report.attributes

    assert_redirected_to \
      service_request_path(assigns(:service_report).service_request.id,
        :notice => 'Service report was successfully updated.')
  end

  test "should destroy service_report" do
    assert_difference('ServiceReport.count', -1) do
      delete :destroy,
        :id => @service_report.to_param,
        :service_request_id => @service_request.to_param
    end

    assert_redirected_to service_request_path(assigns(:service_request))
  end
end
