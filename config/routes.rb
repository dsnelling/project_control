# DS Mar-2011

ActionController::Routing::Routes.draw do |map|
#  map.resources :contracts  #---> need to think if we want to address contracts independently, or just via requsitions
  map.resources :requisitions do |r|
     r.resources :contracts
	 r.resources :req_comments
  end
  map.resources :projects
  map.resources :service_requests
  map.resources :users, :collection => { :login => [:get, :post],
      :change_password => [:get, :post],
	  :logout => [:get] } do |user|
	 user.resources :roles, :collection => { :add_role_to_user => :post,
	    :remove_role_from_user => :post }
  end
  map.resources :rights, :collection => { :roles => :get }, :member => 
      { :add_right => :post, :remove_right => :post } 

# named routes (some is not very @RESTful, but hey, it works!)
  map.root :controller => :main_menu
  map.main_menu '/', :controller => :main_menu
  map.logout '/logout', :controller => :users, :action => :logout 
  map.login '/login', :controller => :users, :action => :login
  map.about '/about', :controller => :main_menu, :action => :about
  map.set_project '/main_menu/set_project', 
      :controller => :main_menu, :action => :set_project
  map.debug_info 'main_menu/debug_info',
     :controller => :main_menu, :action => :debug_info

#default routes
#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'
end
