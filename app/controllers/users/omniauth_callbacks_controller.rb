module Users
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    include Devise::Controllers::Rememberable

    def auth_hash
      @_auth_hash ||= request.env['omniauth.auth']
      @_auth_hash
    end
  end
end

