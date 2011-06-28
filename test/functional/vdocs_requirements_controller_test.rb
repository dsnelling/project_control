require 'test_helper'

class VdocsRequirementsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vdocs_requirements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vdocs_requirement" do
    assert_difference('VdocsRequirement.count') do
      post :create, :vdocs_requirement => { }
    end

    assert_redirected_to vdocs_requirement_path(assigns(:vdocs_requirement))
  end

  test "should show vdocs_requirement" do
    get :show, :id => vdocs_requirements(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => vdocs_requirements(:one).to_param
    assert_response :success
  end

  test "should update vdocs_requirement" do
    put :update, :id => vdocs_requirements(:one).to_param, :vdocs_requirement => { }
    assert_redirected_to vdocs_requirement_path(assigns(:vdocs_requirement))
  end

  test "should destroy vdocs_requirement" do
    assert_difference('VdocsRequirement.count', -1) do
      delete :destroy, :id => vdocs_requirements(:one).to_param
    end

    assert_redirected_to vdocs_requirements_path
  end
end
