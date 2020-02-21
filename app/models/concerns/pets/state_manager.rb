module Pets::StateManager
  extend ActiveSupport::Concern

  included do
    include AASM
    
    aasm(column: 'status', whiny_transitions: false) do
      state :created, initial: true
      state :published, :paused, :archived, :adopted

      event :archive do
        transitions from: [:created, :published, :paused], to: :archived, guard: :reason_code?
      end
    end
  end
end
