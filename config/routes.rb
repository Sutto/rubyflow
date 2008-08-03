ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'items'

  map.resources :items, :collection => {:recently => :get} do |items|
    items.resources :comments
    items.add_star    '/star/add', :controller => "stars", :action => "add"
    items.remove_star '/star/remove', :controller => "stars", :action => "remove"
  end

  map.resources :categories

  map.resources :users
  map.resource :session, :controller => 'session'  


  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'session', :action => 'new'
  map.logout '/logout', :controller => 'session', :action => 'destroy'

  map.tag  '/tag/:id', :controller => 'items', :action => 'list_for_tags'
  map.tags '/tags/:id', :controller => 'items', :action => 'list_for_tags'
  map.tags_by_folders '/tags/*id', :controller => 'items', :action => 'list_for_tags'
  map.search   '/search/:id', :controller => 'items', :action => 'search'
  map.category '/category/:id', :controller => 'items', :action => 'category'

  map.connect '/page/:page', :controller => 'items', :action => 'index'
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
