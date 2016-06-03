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
        put '/', action: :update_many
      end
    end
    resources :properties do
      collection do
        get '/search', action: :search, as: :search
        put '/', action: :update_many
        delete '/', action: :destroy_many
      end
      member do
        get '/edit/(*step)', action: :edit, step: /principal|caracteristicas|media/, as: :edit
        put '/clone', action: :clone, as: :clone
        resources :contacts, only: :index, as: :property_contacts, path: 'notifications' do
          collection do
            delete '/', action: :destroy_many
          end
          get '/', action: :show
        end
      end
    end
    resources :developments do
      collection do
        put '/', action: :update_many
        delete '/', action: :destroy_many
      end
      member do
        get '/edit/(*step)(/:property_id)', action: :edit, step: /principal|propiedades|caracteristicas|media/, as: :edit
        resources :contacts, only: :index, as: :development_contacts, path: 'notifications' do
          collection do
            delete '/', action: :destroy_many
          end
          get '/', action: :show
        end
      end
    end
    resources :contacts, except: [:new, :create], path: 'notifications' do
      collection do
        get 'select', action: :select
        put '/', action: :update_many
        delete '/', action: :destroy_many
      end
    end
    resources :showcase_items do
      collection do
        post 'many', action: :create_many, as: :create_many
        delete '/', action: :destroy_many
      end
    end
    resources :promotions do
      collection do
        post 'many', action: :create_many, as: :create_many
        delete '/', action: :destroy_many
      end
    end
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
  get 'inmueble/(:property_id)' => 'pages#file', as: :property_file
  get 'emprendimiento/(:development_id)' => 'pages#file', as: :development_file
  get 'servicios/tasaciones' => 'pages#assessments', as: :assessments
  get 'servicios/inversiones' => 'pages#investments', as: :investments

end