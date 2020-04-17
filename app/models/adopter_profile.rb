class AdopterProfile < ApplicationRecord
  include AdopterProfile::StateManager

  attr_accessor :has_co_adopter

  STATES = ['personal_info', 'personal_co_adopter', 'personal_final', 'home', 'lifestyle',
            'agreements', 'add_references', 'agreements', 'add_references', 'completed'].freeze

  has_one :address, class_name: "AdopterAddress", as: :addressable, dependent: :destroy
  has_one :employment, as: :employmentable, dependent: :destroy
  has_one :pet_info, dependent: :destroy
  has_one :co_adopter, dependent: :destroy
  has_one :veterinarian, dependent: :destroy
  has_many :references, dependent: :destroy
  belongs_to :adopter, class_name: 'Adopter', foreign_key: 'user_id'

  validates :phone_number, :adopter, presence: true
  validates :home_visit_agreement, :adoption_fee_agreement, acceptance: { message: 'must be accepted' }, if: :agreements?

  accepts_nested_attributes_for :co_adopter, :pet_info, :veterinarian, :references, 
                                :employment, :address, update_only: true

  def completed_status?(status)
    STATES.index(status) <= STATES.index(self.status)
  end
end
