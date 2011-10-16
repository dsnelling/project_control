require 'test_helper'

class ServiceReportsControllerTest < ActionController::TestCase
  setup do
    @service_report = service_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_report" do
    assert_difference('ServiceReport.count') do
      post :create, :service_report => @service_report.attributes
    end

    assert_redirected_to service_report_path(assigns(:service_report))
  end

  test "should show service_report" do
    get :show, :id => @service_report.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @service_report.to_param
    assert_response :success
  end

  test "should update service_report" do
    put :update, :id => @service_report.to_param, :service_report => @service_report.attributes
    assert_redirected_to service_report_path(assigns(:service_report))
  end

  test "should destroy service_report" do
    assert_difference('ServiceReport.count', -1) do
      delete :destroy, :id => @service_report.to_param
    end

    assert_redirected_to service_reports_path
  end
end
