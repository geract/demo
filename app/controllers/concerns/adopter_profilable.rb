module AdopterProfilable
  private

  def redirect_to_profile_step
    render json: {
             error: "Unavailable action, user is in #{current_user.profile.state} state",
             state: current_user.profile.state },
           status: :unprocessable_entity
  end
end
