require 'test_helper'

class VendorDocsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_docs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_doc" do
    assert_difference('VendorDoc.count') do
      post :create, :vendor_doc => { }
    end

    assert_redirected_to vendor_doc_path(assigns(:vendor_doc))
  end

  test "should show vendor_doc" do
    get :show, :id => vendor_docs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => vendor_docs(:one).to_param
    assert_response :success
  end

  test "should update vendor_doc" do
    put :update, :id => vendor_docs(:one).to_param, :vendor_doc => { }
    assert_redirected_to vendor_doc_path(assigns(:vendor_doc))
  end

  test "should destroy vendor_doc" do
    assert_difference('VendorDoc.count', -1) do
      delete :destroy, :id => vendor_docs(:one).to_param
    end

    assert_redirected_to vendor_docs_path
  end
end
