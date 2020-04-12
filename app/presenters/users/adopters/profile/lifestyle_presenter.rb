class Users::Adopters::PetApplications::LifestylePresenter
  def initialize(adopter)
    @lifestyle = adopter.application.applicationable.pet_info.lifestyle
  end

  def response
    { application: {
        applicationable_attributes: {
          pet_info_attributes: {
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
            },
          },
        },
      },
    }
  end

  private

  attr_reader :lifestyle
end
