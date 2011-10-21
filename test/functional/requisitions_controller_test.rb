require 'test_helper'

class RequisitionsControllerTest < ActionController::TestCase

  setup do
    @req1 = {
      :req_num => 'Z44',
      :project => 'knitting',
      :commodity => 'wool',
      :scope => 'JV',
      :status => 'PO'
      }
    p @req1.req_num
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requisitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requisition" do
    p "req_ref: +#{@req1.req_num}+, +#{@req1.project}+"
    assert_difference('Requisition.count') do
      post :create, :requisition => @req1
    end

    assert_redirected_to requisition_path(assigns(:requisition))
  end

  test "should show requisition" do
    get :show, :id => requisitions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => requisitions(:one).to_param
    assert_response :success
  end

  test "should update requisition" do
    put :update, :id => requisitions(:one).to_param, :requisition => { }
    assert_redirected_to requisition_path(assigns(:requisition))
  end

  test "should destroy requisition" do
    assert_difference('Requisition.count', -1) do
      delete :destroy, :id => requisitions(:one).to_param
    end

    assert_redirected_to requisitions_path
  end
end
