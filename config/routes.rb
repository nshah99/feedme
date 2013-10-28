Feedme::Application.routes.draw do
  #get "events/new"
  #get "events/create"
  #get "events/index"
  #get "events/update"
  #get "events/edit"
  #get "events/delete"
  #get "events/show"
  #get "reviews/create"
  #get "reviews/new"
  #get "reviews/index"
  #get "reviews/show"
  #get "reviews/update"
  #get "reviews/delete"
  #get "orders/new"
  #get "orders/create"
  #get "orders/show"
  #get "orders/index"
  resources :events do 
       member do
         get :attent_event , :only=>[:show,:index]
       end
  end
  resources :locations
  resources :relationships, only: [:create, :destroy]
  resources :listings do
    member { post :vote}
  end
  resources :orders
  resources :reviews
  #get "users/new"
  #get "users/create"
  #get "users/update"
  #get "users/delete"
  resources :users do
    resources :events do
            member do
               get 'attend', :only => [:new,:create,:edit,:update]
            end
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  match '/signup',  to: 'users#new',  via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  get "static_pages/about"
  get "static_pages/contact"
  get "static_pages/home"
  get "static_pages/help"
  root 'users#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
