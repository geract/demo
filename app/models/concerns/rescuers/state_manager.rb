module Rescuers::StateManager
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm(column: 'status', whiny_transitions: false) do
      state :created, initial: true
      state :archived, initial: true

      event :archive do
        transitions from: :created, to: :archived
      end
    end
  end
end
