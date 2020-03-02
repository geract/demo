Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

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
        resources :pets
        resources :pets_statuses, only: %i(update)
        resource :organizations, only: %i(show update)
        resources :rescuers, only: %i(index create show update)
        resource :pet_bulk, only: %i(update)
        resources :rescuer_statuses, only: %i(update)
      end
      resources :characteristics_options, only: %i(index)
      resources :pets, only: %i(index show)
    end
  end

  resources :pets, only: :show
end
