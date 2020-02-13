Rails.application.routes.draw do
  mount_devise_token_auth_for 'Users', at: '/auth'
  devise_for :admins, path: 'admin', 
    controllers: { 
      sessions: "admins/sessions"
    }
end
