class AdopterProfile < ApplicationRecord
  include AdopterProfile::StateManager
  delegate :email, to: :adopter

  attr_accessor :has_co_adopter

  STATES = ['personal_info', 'personal_co_adopter', 'personal_final', 'home', 'lifestyle',
            'agreements', 'add_references', 'agreements', 'add_references', 'completed'].freeze

  PREFERENCES_FIELDS = ['age', 'sex', 'size', 'hair', 'energy', 'breed', 'special_needs']

  has_one :address, class_name: "AdopterAddress", as: :addressable, dependent: :destroy
  has_one :employment, as: :employmentable, dependent: :destroy
  has_one :pet_info, dependent: :destroy
  has_one :co_adopter, dependent: :destroy
  has_one :veterinarian, dependent: :destroy
  has_many :references, dependent: :destroy
  has_many :pet_applications
  belongs_to :adopter, class_name: 'Adopter', foreign_key: 'user_id'

  validates :phone_number, :adopter, :family_status, :pronoun, presence: true
  validates :home_visit_agreement, :adoption_fee_agreement, acceptance: { message: 'must be accepted' }, if: :agreements?

  store :preferences, accessors: PREFERENCES_FIELDS

  accepts_nested_attributes_for :co_adopter, :pet_info, :veterinarian, :references, 
                                :employment, :address, update_only: true

  def completed_status?(status)
    STATES.index(status) <= STATES.index(self.status)
  end
end
