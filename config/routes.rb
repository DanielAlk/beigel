Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  devise_for :admins, controllers: { 
    registrations: 'admins/registrations', 
    sessions: 'admins/sessions', 
    passwords: 'admins/passwords'
  }

  post 'buscar', to: 'search#index', as: :search
  get '*search', to: 'search#results', search: /comprar.*|alquilar.*/, as: :results

  get 'emprendimientos' => 'pages#developments', as: :developments
  get 'empresas-amigas' => 'pages#friends', as: :friends
  get 'la-empresa' => 'pages#about', as: :about
  get 'contacto' => 'pages#contact', as: :contact
  get 'servicios' => 'pages#services', as: :services
  get 'ficha-tecnica' => 'pages#file', as: :file
  get 'servicios/tasaciones' => 'pages#assessments', as: :assessments
  get 'servicios/inversiones' => 'pages#investments', as: :investments

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
