# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#
#-- set up rights for procurement_docs controller
=begin
    ---commented out
controller = "procurement_docs"
["create","destroy","edit","new","show","update"].each do |action|
  name=controller.capitalize << " " << action.capitalize
   r = Right.find_or_create_by_name(name)
   r.update_attributes(:controller => controller, :action => action)
end

=end

