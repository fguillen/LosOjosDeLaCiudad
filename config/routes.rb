ActionController::Routing::Routes.draw do |map|
  map.resources :cameras, :member => { :widget => :get }  
  map.snapshot '/cameras/:camera_id/snapshots/:datetime/:size', :controller => 'cameras', :action => 'snapshot'
  map.login '/login/:password', :controller => 'login', :action => 'login'
  map.logout '/logout', :controller => 'login', :action => 'logout'
  map.root :controller => "cameras"
end
