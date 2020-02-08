Rails.application.routes.draw do
  devise_for :admins, path: 'admin', 
    controllers: { 
      sessions: "admins/sessions"
    }
  
  authenticate :admin do
    resources :organizations do
      resources :organizations_adresses
    end
  end
end
