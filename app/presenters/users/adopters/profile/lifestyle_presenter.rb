class Users::Adopters::Profile::LifestylePresenter
  def initialize(adopter)
    @profile = adopter.profile
    @lifestyle = profile.pet_info.lifestyle
  end

  def response
    { profile: {
        id: profile.id,
        pet_info_attributes: {
          id: profile.pet_info.id,
          lifestyle: {
            living_place: lifestyle[:living_place],
            bad_weather_plan: lifestyle[:bad_weather_plan],
            hours_left: lifestyle[:hours_left],
            alone_place: lifestyle[:alone_place],
            walk_explanation: lifestyle[:walk_explanation],
            trainer: lifestyle[:trainer],
            energy: lifestyle[:energy],
            train_plan: lifestyle[:train_plan],
            experiences: lifestyle[:experiences],
          }
        }
      }
    }
  end

  private

  attr_reader :profile, :lifestyle
end
