Rails.application.routes.draw do

  constraints subdomain: lambda { |sd| !sd[/stage/] && !sd[/panel/] } do
    get '(*soon)', to: 'pages#soon'
  end

  constraints subdomain: /panel/ do
    get '/', to: 'panel#index', as: :panel

    devise_for :admins, controllers: { 
      registrations: 'admins/registrations', 
      sessions: 'admins/sessions', 
      passwords: 'admins/passwords'
    }

    resources :images, :defaults => { :format => :json } do
      collection do
        put '/', to: :update_all, as: :update_all
      end
    end
    resources :properties do
      collection do
        get '/search', to: :search, as: :search
      end
      member do
        get '/edit/(*step)', to: :edit, step: /principal|caracteristicas|media/, as: :edit
        put '/clone', to: :clone, as: :clone
        resources :contacts, only: :index, as: :property_contacts, path: 'notifications' do
          collection do
            delete '/', to: :destroy_all
          end
          get '/', to: :show
        end
      end
    end
    resources :developments do
      member do
        get '/edit/(*step)(/:property_id)', to: :edit, step: /principal|propiedades|caracteristicas|media/, as: :edit
        resources :contacts, only: :index, as: :development_contacts, path: 'notifications' do
          collection do
            delete '/', to: :destroy_all
          end
          get '/', to: :show
        end
      end
    end
    resources :contacts, except: [:new, :create], path: 'notifications' do
      collection do
        get 'select', to: :select
        put '/', to: :update_all
        delete '/', to: :destroy_all
      end
    end
    resources :showcase_items
    resources :promotions
  end

  root 'pages#home'

  post 'buscar', to: 'search#index', as: :search
  get '*search', to: 'search#results', search: /comprar.*|alquilar.*/, as: :results

  resources :contacts, only: :create, path: 'notifications'

  get 'home', to: 'pages#home', as: :home
  get 'emprendimientos' => 'pages#developments', as: :developments_page
  get 'promociones' => 'pages#promotions', as: :promotions_page
  get 'empresas-amigas' => 'pages#friends', as: :friends
  get 'la-empresa' => 'pages#about', as: :about
  get 'contacto' => 'pages#contact', as: :contact_page
  get 'servicios' => 'pages#services', as: :services
  get 'ficha-propiedad/(:property_id)' => 'pages#file', as: :property_file
  get 'ficha-emprendimiento/(:development_id)' => 'pages#file', as: :development_file
  get 'servicios/tasaciones' => 'pages#assessments', as: :assessments
  get 'servicios/inversiones' => 'pages#investments', as: :investments

end