class Users::Adopters::Profile::LifestylePresenter
  def initialize(adopter)
    @profile = adopter.profile
    @pet_info = profile.pet_info
  end

  def as_json(*)
    { profile: {
        id: profile.id,
        pet_info_attributes: {
          id: profile.pet_info.id,
          lifestyle: {
            living_place: pet_info.living_place,
            bad_weather_plan: pet_info.bad_weather_plan,
            hours_left: pet_info.hours_left,
            alone_place: pet_info.alone_place,
            walk_explanation: pet_info.walk_explanation,
            trainer: pet_info.trainer,
            energy: pet_info.energy,
            train_plan: pet_info.train_plan,
            experiences: pet_info.experiences,
          }
        }
      }
    }
  end

  private

  attr_reader :profile, :pet_info
end
