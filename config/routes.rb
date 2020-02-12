Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  devise_for :admins, path: 'admin', 
    controllers: { 
      sessions: "admins/sessions"
    }
  
  authenticate :admin do
    root to: 'organizations#new'
    resources :organizations do
      resources :organizations_adresses
    end
  end
end
