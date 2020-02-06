Rails.application.routes.draw do
  devise_for :admins, path: 'admin', 
    controllers: { 
      sessions: "admins/sessions",
      registrations: 'users/registrations'
    }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
