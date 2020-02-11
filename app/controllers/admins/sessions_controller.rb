# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: %i[new create destroy]

  def new
    render json: {authenticity_token: form_authenticity_token}, status: "200"
  end
  
  def create
    super

    render json: {signed_in: admin_signed_in?}, status: "200"
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end

