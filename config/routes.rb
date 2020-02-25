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

  namespace :users, path: 'user' do
    api_version(module: 'v1', header: {name: 'API-VERSION', value: '1'}) do
      resources :pets
      resources :pets_statuses, only: [:update]
      resources :characteristics_options, only: %i(index)
      resources :organizations, only: %i(show update)
      resources :rescuers, only: %i(create show update)
    end
  end
end
