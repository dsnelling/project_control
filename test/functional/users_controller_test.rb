require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures :users

  #test "index without user" do
  #  get :index
  #    assert_redirected_to login_url
  #    assert_equal "Failed authentication...", flash[:notice]
  #end

  test "index with user" do
    get :index, {}, { :user_id => users(:user_jim).id }
	assert_response :success
	assert_template "index"
  end

  test "should_login" do
    dave = users(:user_dave)
    pw = "secret"
    post :login, :username => dave.username, :password => pw
    assert_redirected_to main_menu_path
	assert_equal dave.id, session[:user_id]
  end

  test "bad password" do
    jim = users(:user_jim)
    pw = "password_jim"
    jim.password = pw
    jim.save
    post :login, :username => jim.username, :password => "wrong_pw"
    assert_template "login"
    assert_equal "Invalid user/password!!", flash[:notice]
  end

  test "change password screen" do
    get :change_password, {}, { :user_id => users(:user_jim).id }
    assert_response :success
    assert_template "change_password"
  end

  test "change password" do
    pw = "password_henry"
    henry = User.new(:username => "henry",
	        :email_addr => "henry@somewhere.com",
	        :password => pw)
	assert henry.save
    henry2 = User.find_by_username("henry")
    post :change_password, { :old_password => pw, :new_password => "new_pw",
	  :confirm_password => "new_pw" },
	  { :user_id => henry2.id, :username => henry2.username }
	assert_equal "Password successfully updated ... for #{henry.username}", 
	  flash[:notice]
  end

  test "change password jim" do
    pw = "password_jim"
    jim = users(:user_jim)
	jim.password = pw
	jim.save
    post :change_password, { :old_password => pw, :new_password => "new_pw",
	  :confirm_password => "new_pw" },
	  { :user_id => jim.id, :username => jim.username }
	assert_equal "Password successfully updated ... for #{jim.username}", 
	  flash[:notice]
  end

  test "change password wrong" do
    pw = "password_henry"
    henry = User.new(:username => "henry",
	        :email_addr => "henry@somewhere.com",
	        :password => pw)
	assert henry.save
    henry2 = User.find_by_username("henry")
    post :change_password, { :old_password => pw, :new_password => "new_pw",
	  :confirm_password => "new_pw_wrong" },
	  { :user_id => henry2.id, :username => henry2.username }
	assert_equal "Password not updated", flash[:notice]
	assert_template "change_password"
  end
end
