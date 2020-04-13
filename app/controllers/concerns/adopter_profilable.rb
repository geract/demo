module AdopterProfilable
  private

  def adopter_profile?
    !!current_user.profile.pet_info
  end

  def next_profile_step
    [:adopters, current_user.profile.state]
  end

  def redirect_to_first_profile_step
    redirect_to %i[adopters personal_info]
  end

  def redirect_to_next_profile_step
    redirect_to next_profile_step
  end  
end
