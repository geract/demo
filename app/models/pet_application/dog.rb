# frozen_string_literal: true

class PetApplication::Dog < ApplicationRecord
  include AASM

  STATES = ['personal_info', 'personal_co_adopter', 'personal_final', 'home', 'lifestyle', 'completed'].freeze

  has_one :application, as: :applicationable, class_name: 'PetApplication'
  has_one :pet_info

  accepts_nested_attributes_for :pet_info

  aasm(:state, column: 'state', whiny_transitions: false) do
    state :personal_info, initial: true
    state :personal_co_adopter, :personal_final, :home, :lifestyle, :completed

    event :continue_application do
      transitions from: :personal_info, to: :personal_co_adopter
      transitions from: :personal_co_adopter, to: :personal_final
      transitions from: :personal_final, to: :home
      transitions from: :home, to: :lifestyle
      transitions from: :lifestyle, to: :completed
    end

    event :skip_co_adopter do
      transitions from: :personal_info, to: :personal_final
    end
  end

  def completed_state?(state)
    STATES.index(state) <= STATES.index(self.state)
  end
end
