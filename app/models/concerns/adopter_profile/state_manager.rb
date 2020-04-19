module AdopterProfile::StateManager
  extend ActiveSupport::Concern

  included do
    include AASM
    
    aasm(column: 'status', whiny_transactions: false) do
      state :personal_info, initial: true
      state :personal_co_adopter, :personal_final, :home, :lifestyle,
            :agreements, :add_references, :completed

      event :continue do
        transitions from: :personal_info, to: :personal_co_adopter
        transitions from: :personal_co_adopter, to: :personal_final
        transitions from: :personal_final, to: :home
        transitions from: :home, to: :lifestyle
        transitions from: :lifestyle, to: :agreements
        transitions from: :agreements, to: :add_references, guard: -> { accepted_agreements? }
        transitions from: :add_references, to: :completed
      end

      event :skip_co_adopter do
        transitions from: :personal_info, to: :personal_final
      end
    end

    private

    def accepted_agreements?
      home_visit_agreement && adoption_fee_agreement
    end
  end
end
