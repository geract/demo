# frozen_string_literal: true

class Reference < ApplicationRecord
  RELATIONSHIPS = %w[Parent Sibling Family Friend Neighbor Coworker].freeze
  ADDITIONAL_FIELDS = %w[how_you_know years adopter_has_pets adopter_pet_kind adopter_pet_treatment
    adopter_pet_location adopter_home_safe adopter_has_children adopter_pet_expectation adopter_has_income
    adopter_reservations additional_information interested_in_pets].freeze

  attr_reader *ADDITIONAL_FIELDS

  belongs_to :adopter_profile, class_name: 'AdopterProfile'

  validates :first_name, :last_name, :email, presence: true
  validates :relationship, presence: true, inclusion: RELATIONSHIPS
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end
