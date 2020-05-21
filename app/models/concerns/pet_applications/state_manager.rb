module PetApplications::StateManager
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm(column: 'status', whiny_transitions: false) do
      state :created, initial: true
      state :archived, :adopted, :rejected

      event :archive do
        transitions from: :created, to: :archived
      end

      event :reject, after: :set_rejected_at do
        transitions from: :created, to: :rejected, guard: :validate_rejection_details
      end
    end

    private

    def set_rejected_at
      self.rejected_at = Time.current
      self.save
    end

    def validate_rejection_details
      return true if rejection_details.present?

      errors.add(:rejection_details,
                 'is required when trying to reject a pet application')
      false
    end
  end
end
