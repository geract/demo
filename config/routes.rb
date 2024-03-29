Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', 
    controllers: { 
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'users/v1/adopters/registrations'
    }

  devise_for :admins, only: :sessions, path: '/admin',
             path_names: { sign_in: 'login', sign_out: 'logout' },
             controllers: { sessions: 'admins/sessions' }

  devise_scope :admin do
    authenticated :admin do
      get '/admin', to: 'admins/organizations#index', as: :admin_root
    end
    unauthenticated do
      get '/admin', to: 'devise/sessions#new'
    end
  end

  namespace :admins, path: 'admin' do
    root to: 'admins/organizations#index'
    resources :organizations
  end

  scope module: 'users' do
    api_version(module: 'v1', header: {name: 'API-VERSION', value: '1'}) do 
      namespace :rescuers, path: 'rescuer' do
        resources :pets_statuses, only: %i(update)
        resource :organizations, only: %i(show update)
        resources :rescuers, only: %i(index create show update)
        resource :pet_bulk, only: %i(update)
        resources :rescuer_statuses, only: %i(update)
        resource :profile, only: %i(show update)
        resources :pet_applications_statuses, only: %i(update)

        resources :pets, shallow: true do
          scope module: 'pets' do
            resources :pet_applications, only: %i(index)
          end
        end

        resources :pet_applications, only: %i(index) do
          scope module: 'pet_applications' do
            resource :favorites, only: %i(create destroy)
            resource :profiles, only: %i(show)
            resource :applications, only: %i(show)
            resources :messages, only: %i(index create)
          end
        end

        resources :surveys, only: %i(index)
      end

      namespace :adopters, path: 'adopter' do
        resource :searches, only: %i(update)
        resources :messages, only: %i(index create)
        resources :pets, only: %i(index show) do
          resource :favorites, only: %i(create destroy), controller: 'pets/favorites'
          collection do
            resources :favorites, only: %i(index), controller: 'pets/favorites'
          end
        end
        resource :pet_applications, only: %i(create)
        resource :personal_info, only: %i(show update)
        resource :personal_co_adopter, only: %i(show update)
        resource :personal_final, only: %i(show update)
        resource :home, only: %i(show update)
        resource :lifestyle, only: %i(show update)
        resource :agreements, only: %i(show update)
        resource :references, only: %i(show update), as: :add_references
      end

      resources :characteristics_options, only: %i(index)
      resources :pets, only: %i(index show)
      resources :organizations, only: %i(show)
      resources :newsletter, only: %i(create)
      resources :inqueries, only: %i(create)
    end
  end

  resources :pets, only: :show
end
