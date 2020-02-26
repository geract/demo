module Pets::StateManager
  extend ActiveSupport::Concern

  included do
    include AASM
    
    aasm(column: 'status', whiny_transitions: false) do
      state :created, initial: true
      state :published, :paused, :archived, :adopted

      event :archive do
        transitions from: [:created, :published, :paused], to: :archived, guard: :validate_reason_code
      end

      event :publish do
        transitions from: [:created, :paused, :archived], to: :published
      end
    end

    private

    def validate_reason_code
      return true if reason_code.present?

      errors.add(:reason_code, 'Reason code is required when trying to archive a pet')
      false
    end
  end
end
