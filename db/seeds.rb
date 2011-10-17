# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#
#-- new roles

#create admin user if doesn't exist 
=begin
unless User.find_by_username("admin01")
    a = User.new(
	  :username => "admin01",
      :superuser => true,
      :email_addr => "somewhere@elsewhere.com",
      :password => "secret01")
    a.save
  end
=end


#-- set up rights
#  role = Role.find_or_create_by_name("Doc Controller")

rights_to_roles = {
  "Basic View" => ["index","show"],
  "Admin" => ["create","destroy","edit","index","new","show","update"],
  "Project Manager" =>
     ["create","destroy","edit","index","new","show","update"],
  "Doc Controller" => 
     ["create","destroy","edit","index","new","show","update"],
  "Service Request View" =>
     ["show"]
}


["service_reports"].each do |controller|
  ["create","destroy","edit","index","new","show","update"].each do |action|
    name=controller.capitalize << " " << action.capitalize
     r = Right.find_or_create_by_name(name)
     r.update_attributes(:controller => controller, :action => action)
  end



  rights_to_roles.each do |role,actions|
    ro = Role.find_by_name(role)
    actions.each do |action|
      name = controller.capitalize << " " << action.capitalize
      if right = Right.find_by_name(name)
	  ro.rights << right
      end
    end
  end

end
