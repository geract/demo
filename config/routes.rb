Rails.application.routes.draw do
  devise_for :admins, path: 'admin',
  controllers: { 
    sessions: "admins/sessions"
  }
  
  namespace :users, path: 'user' do
    mount_devise_token_auth_for 'User', at: '/auth'
  end
end
