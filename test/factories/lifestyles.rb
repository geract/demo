FactoryBot.define do
  factory :application_lifestyle_params, class: Hash do
    body do
      { profile: { 
          pet_info_attributes: {
            lifestyle: {
              living_place: 'String',
              bad_weather_plan: 'String',
              hours_left: 'String',
              alone_place: 'String',
              walk_explanation: 'String',
              trainer: 'String',
              energy: 'String',
              train_plan: 'String',
              experiences: 'String',
            }
          }
        }
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
