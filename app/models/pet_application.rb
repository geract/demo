class PetApplication < ApplicationRecord
  include AASM

  STATES = ['filling', 'agreements', 'add_references', 'completed'].freeze

  belongs_to :adopter
  belongs_to :veterinarian, optional: true
  belongs_to :co_adopter, class_name: 'Adopter', optional: true, foreign_key: :co_adopter_id
  belongs_to :applicationable, polymorphic: true
  belongs_to :pet

  has_one :pet_info, through: :applicationable
  has_one :profile, through: :adopter

  has_many :references, foreign_key: :application_id

  accepts_nested_attributes_for :profile, :co_adopter, :applicationable,
                                :pet_info, :veterinarian, :references

  delegate :continue_application, :continue_application!, :skip_co_adopter!, to: :applicationable, allow_nil: true

  validates :home_visit_agreement, :adoption_fee_agreement, acceptance: { message: 'must be accepted' }, if: :agreements?

  aasm(column: 'state', whiny_transactions: false) do
    state :filling, initial: true
    state :agreements, :add_references, :completed

    event :continue do
      transitions from: :filling, to: :agreements, guard: -> { applicationable&.completed? }
      transitions from: :agreements, to: :add_references, guard: -> { accepted_agreements? }
      transitions from: :add_references, to: :completed
    end
  end

  def completed_state?(state)
    STATES.index(state) <= STATES.index(self.state)
  end

  private

  def accepted_agreements?
    home_visit_agreement && adoption_fee_agreement
  end
end
