# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#
#-- new roles


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

#-- set up rights for library_docs controller
#controller = "library_docs"
controller = "vdocs_requirements"
#controller = "vendor_docs"
["create","destroy","edit","index","new","show","update"].each do |action|
  name=controller.capitalize << " " << action.capitalize
   r = Right.find_or_create_by_name(name)
   r.update_attributes(:controller => controller, :action => action)
end

role = Role.find_or_create_by_name("Doc Controller")

# maybe there's a clever way to do this
rights_to_roles = {
  "Basic View" => ["index","show"],
  "Admin" => ["create","destroy","edit","index","new","show","update"],
  "Project Manager" =>
     ["create","destroy","edit","index","new","show","update"],
  "Doc Controller" => 
     ["create","destroy","edit","index","new","show","update"]
  }


rights_to_roles.each do |role,actions|
  ro = Role.find_by_name(role)
  actions.each do |action|
    name = controller.capitalize << " " << action.capitalize
    if right = Right.find_by_name(name)
	  ro.rights << right
	end
  end
end



