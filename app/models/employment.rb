class Employment < ApplicationRecord
  STATUSES = %w[Self-Employed Employed Unemployed Retired].freeze
  YEARS = ['<1 year', '1-2 years', '3+ years'].freeze

  has_one :address, class_name: "AdopterAddress", as: :addressable

  validates :status, presence: true, inclusion: STATUSES
  validates :years, presence: true, inclusion: YEARS
  validates :company, presence: true
  validates :address, presence: true, unless: :without_address?
  validates :pet_costs, presence: true, if: -> { without_address? && !skip_costs_for_co_adopter }

  belongs_to :employmentable, polymorphic: true

  accepts_nested_attributes_for :address

  before_validation :unset_address, if: :without_address?

  attr_accessor :skip_costs_for_co_adopter
  
  def retired?
    status =~ /Retired/i
  end

  def un_employed?
    status =~ /Unemployed/i
  end

  def without_address?
    retired? || un_employed?
  end

  private

  def unset_address
    self.address = nil
  end
end
