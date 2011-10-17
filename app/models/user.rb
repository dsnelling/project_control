require 'digest/sha2'
# keeps detrails of users, including authentication details
# uses right/role based authorisation
#
class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  attr_reader :password
  has_and_belongs_to_many :roles
  validates :username, :presence => true, :uniqueness => true
  validates :email_addr, :format => {
    :with => /^[0-9A-Za-z\._\-]+@[0-9A-Za-z_\.\-]+/,
    :message => "email address invalid"
    }
  #validates_confirmation_of :password
  validate :password_must_be_present

  # generates salt and hashed password as methods of the user instance
  def password=(pass)
	salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
	self.password_salt, self.password_hash = salt, \
		Digest::SHA256.hexdigest(pass + salt)
	end

  def password
    @password
  end

  #return the user instance is password OK, otherwise return nil 
  def self.authenticate(username, password)
    return if password.blank?
    user = self.find_by_username(username)
	if user
	  expected_pw = Digest::SHA256.hexdigest(password + user.password_salt)
	  if expected_pw != user.password_hash || user.disabled
	    user = nil
	  end
	end
	user
  end

  # adds the identified role to the user
  def add_role(role)
     roles << role unless roles.find_by_id(role)
  end

  def remove_role(role)
    roles.delete(role) if roles.find_by_id(role)
  end

  #return true if the current user has the right
  def has_right?(r)
	self.roles.detect {|role| role.rights.detect {|right| right.name == 
	  r }}  || self.superuser
  end

private
  def password_must_be_present
    errors.add(:password, "Missing password") unless password_hash.present?
  end
	
end
