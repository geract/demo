class AdopterProfile < ApplicationRecord
  has_one :address, class_name: "AdopterAddress", as: :addressable, dependent: :destroy
  has_one :employment, as: :employmentable, dependent: :destroy

  belongs_to :adopter, inverse_of: :profile

  validates :phone_number, :adopter, presence: true
  validates :terms, acceptance: { message: 'must be accepted' }, unless: :is_from_co_adopter

  accepts_nested_attributes_for :address, :employment

  attr_accessor :is_from_co_adopter
end
