# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy

  def new
    render json: {authenticity_token: form_authenticity_token}, status: "200"
  end

  def create
  end
end
