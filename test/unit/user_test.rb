require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @user = User.new
    @jim = users(:user_jim)
    @fred = users(:user_fred)
    @apple = User.new(:username => "user_apple",
	  :email_addr => "apple@tree.org", :password => "granny-smith")
  end

  test "add_user" do
    @user.username = "user_william"
    @user.password = "williams_pw"
    @user.email_addr = "willam@the_palace.org"
    assert @user.save, @user.errors.full_messages
  end

  test "unique_user" do
    @user.username = "user_jim"
    @user.email_addr = "email@no10.org"
    @user.password = "hello, all"
    assert !@user.save,  "succeeded in adding duplicate user"
  end


  test "email_format" do
    @user.username = "user_alan"
    @user.password = "allans password"
    @user.email_addr = "alan"
    assert @user.invalid?, "adding invlaid email_addr"
    @user.email_addr = "alan@somewhere.com"
    assert @user.valid?, @user.errors.full_messages
  end

  test "password present" do
    @user.username = "princess"
    @user.email_addr = "princess@holyrood.org"
    assert @user.invalid? "missing password"
    @user.password = "spangly_stuff"
    assert @user.valid?, @user.errors.full_messages
  end

  test "password_match" do
    @apple.save
    assert_not_nil @apple.password_salt, "missing password salt"
    assert_not_nil @apple.password_hash, "missing password_hash"
    assert_nil User.authenticate("user_apple","wrong_password")
    assert_equal  "user_apple", User.authenticate("user_apple","granny-smith").username

  end

end
