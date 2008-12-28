ActionController::Routing::Routes.draw do |map|
  map.resources :computers, :collection => { :available => :get, :unavailable => :get,
    :auto_complete_for_computer_name => :get, :auto_complete_for_computer_ip => :get,
    :auto_complete_for_computer_mac => :get }

  map.resources :mother_boards, :collection => {:auto_complete_for_mother_board_title => :get,
    :auto_complete_for_mother_board_serialnumber => :get}

  map.resources :harddisks, :collection => {:auto_complete_for_harddisk_model => :get,
    :auto_complete_for_harddisk_serialnumber => :get}

  map.resources :memories, :collection => {:auto_complete_for_memory_model => :get,
    :auto_complete_for_memory_serialnumber => :get}

  map.resources :cds, :collection => {:auto_complete_for_cd_model => :get,
    :auto_complete_for_cd_serialnumber => :get}

  map.resources :dvds, :collection => {:auto_complete_for_dvd_model => :get,
    :auto_complete_for_dvd_serialnumber => :get}

  map.resources :screens, :collection => {:auto_complete_for_screen_model => :get,
    :auto_complete_for_screen_serialnumber => :get}

  map.resources :printers, :collection => {:auto_complete_for_printer_model => :get,
    :auto_complete_for_printer_serialnumber => :get}

  map.resources :marks

  map.root :controller => 'computers'


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
