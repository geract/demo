class Users::BaseController < ApplicationController
  before_action :authenticate_user!

  include DeviseTokenAuth::Concerns::SetUserByToken
end
