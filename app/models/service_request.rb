class ServiceRequest < ActiveRecord::Base
  validates_presence_of :project, :request_ref, :description
  validates_length_of :request_ref, :description, :minimum => 5
end
