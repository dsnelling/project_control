require 'test_helper'

class ProcurementDocsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:procurement_docs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create procurement_doc" do
    assert_difference('ProcurementDoc.count') do
      post :create, :procurement_doc => { }
    end

    assert_redirected_to procurement_doc_path(assigns(:procurement_doc))
  end

  test "should show procurement_doc" do
    get :show, :id => procurement_docs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => procurement_docs(:one).to_param
    assert_response :success
  end

  test "should update procurement_doc" do
    put :update, :id => procurement_docs(:one).to_param, :procurement_doc => { }
    assert_redirected_to procurement_doc_path(assigns(:procurement_doc))
  end

  test "should destroy procurement_doc" do
    assert_difference('ProcurementDoc.count', -1) do
      delete :destroy, :id => procurement_docs(:one).to_param
    end

    assert_redirected_to procurement_docs_path
  end
end
