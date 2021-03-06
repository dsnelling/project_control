# DS Sep-2011 - migrated to Rails 3

ProjectControl::Application.routes.draw do

  resources :library_docs
  resources :incidents
  resources :site_hours
  resources :requisitions do
    get :report, :on => :collection
    get :export, :on => :collection
    resources :req_comments
    resources :procurement_docs
    resources :contracts
  end
  resources :contracts, :shallow => true do
    resources :vdocs_requirements do
      resources :vendor_docs
    end
    get :expedite, :on => :collection
    get :expedite_show, :on => :member
    get :expedite_edit, :on => :member
    put :expedite_update, :on => :member
  end
  resources :projects
  resources :service_requests do
    get :report, :on => :collection
    get :export, :on => :collection
    resources :service_reports
  end
  resources :users do
    collection do
	  get :login
	  post :login
	  get  :change_password
	  post :change_password
	  get :logout
	end
	# the roles is a bit messy. index, add_role, remove_role are associated 
	# with a particular user, whilst....
	resources :roles, :only => [:index ] do
	  collection do
	    post :add_role_to_user
		post :remove_role_from_user
	  end
    end
  end
  # ... create and update roles is the list of roles to choose from, independant
  # of an individual user. It works....
  resources :roles, :only => [:create, :update]
  resources :rights do
    collection do
	  get :roles
	end
	member do
	  post :add_right
	  post :remove_right
	end
  end

# non-resourceful routes
  root :to => 'main_menu#index', :as => 'main_menu'
  match 'logout' => 'users#logout', :as => 'logout'
  match 'login' => 'users#login', :as => 'login'
  get 'main_menu/about', :as => 'about'
  match 'main_menu/set_project' => 'main_menu#set_project',
    :as => 'set_project', :via => :post
  match 'debug_info' => 'main_menu#debug_info'

end
