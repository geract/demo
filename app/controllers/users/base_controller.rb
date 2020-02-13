class Users::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  protect_from_forgery with: :null_session, unless: -> { request.format.json? }
  respond_to :json
end
