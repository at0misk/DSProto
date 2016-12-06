Rails.application.routes.draw do
  get 'carts/index'
  get 'cats' => 'categories#partial'
  get 'productsNg' => 'categories#productsNg'
  get 'learn' => 'sessions#learn'
  get 'pricing' => 'sessions#pricing'
  get 'contact' => 'sessions#contact'
  get 'users/edit' => 'users#edit'
  get 'cart' => 'carts#view'
  get 'productsIndex' => 'products#index'
  get 'productsAll' => 'products#all'
  get 'sessions/new'
  post 'products' => 'products#create'
  post 'checkout' => 'carts#checkout'
  get 'cacheAll' => 'products#cacheAll'
  get 'cacheCats' => 'categories#cacheCats'
  get 'search' => 'products#search'
  post 'search' => 'products#searchQ'
  get 'qProductAng' => 'products#searchQAng'
  patch 'carts/:id' => 'carts#update'
  delete 'carts/:id' => 'carts#delete'
  get 'logout' => 'sessions#destroy'
  patch 'users' => 'users#update'

  get 'sessions/index'

  get 'session/index'

  get 'users/index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'users#index'
  root 'sessions#about'
  get 'about' => 'sessions#about'
  get 'signup' => 'sessions#new'
  post 'signup' => 'users#create'
  get 'categories' => 'categories#index'
  get 'categories/:name/' => 'categories#view', :constraints => {:name => /.*/}
  get 'products/:id/:name/:man/:num' => 'products#view', :constraints => {:man => /.*/, :num => /.*/, :name => /([^\/])+?/}
  post 'login' => 'sessions#login'
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
