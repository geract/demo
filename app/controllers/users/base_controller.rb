class Users::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
end
