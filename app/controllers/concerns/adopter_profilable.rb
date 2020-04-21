module AdopterProfilable
  private

  def redirect_to_profile_step
    render json: {
             error: "Unavailable action, user is in #{current_user.profile.status} status",
             status: current_user.profile.status },
           status: :conflict
  end
end
