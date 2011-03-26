# contains controller#model combinations that are permitted by a right
#
class Right < ActiveRecord::Base
  has_and_belongs_to_many :roles
end
