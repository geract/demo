FactoryBot.define do
  factory :agreements_params, class: Hash do
    body do
      { application: { 
          home_visit_agreement: true,
          adoption_fee_agreement: true,
        }
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
