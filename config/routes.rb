Bitlag::Application.routes.draw do

namespace :api, defaults: {format: 'json'} do
  match 'events' => 'events#get_events', :as => :get_events
  end

  resources :users

  get "home/index"

  get "home/fb_login"

  resources :events

  get "utily/fbtest"  
  root :to => 'home#index'
  
  #facebook callback y logout
  match 'callback' => 'utily#callback'  
  match 'logout' => 'utily#logout'
  
  #agregar eventos 
  match 'admin' => 'admin#index'
  match "add_events" => 'admin#add_events', :as => 'add_events'
  match "admin/refresh" => 'admin#refresh_count'
  
  match 'maps' => 'events#maps', :as => 'maps'
  
  match 'lists' => 'events#lists', :as => 'lists'

  #obtener informacion extra evento (hombres/mujeres)
  match 'extrainfo/:fb_id' => 'events#extraInfo', :as => 'extrainfo'
  
  #ajax list refres
  match 'refreshList/:offset/:filter/:search' => 'events#refreshlist', :as => 'refreshList'
  
  #ajax filter
  match 'filter' => 'events#filter', :as => 'filter'
  
  #REST access token users
  match 'getAccesTokens' => 'users#getAccesTokens', :as => 'getAccesTokens'
  
  #REST add tags
  match 'addTags/:tag_id/:event_id' => 'events#addTags', :as => 'addTags'
  
  
 
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
