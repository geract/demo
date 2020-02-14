# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
<<<<<<< HEAD
  include Accessible
  skip_before_action :check_user, only: %i[destroy]
=======
  before_action :authenticate_admin!
  
  protected
  
  def after_sign_out_path_for(_resource_or_scope)
    new_admin_session_path
  end
>>>>>>> master
end

