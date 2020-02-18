class Organization < ApplicationRecord
  has_one :legal_address
  has_many :physical_addresses

  validates :name, presence: true
  validates :director, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :legal_address, presence: true

  scope :by_name, -> { order(:name) }

  before_validation :validate_organization_type
  before_validation :validate_physical_addresses
  before_save :validate_before_validation

  accepts_nested_attributes_for :legal_address, update_only: true
  accepts_nested_attributes_for :physical_addresses, update_only: true, allow_destroy: true

  private

  def validate_organization_type
    return if sheltered || foster_based

    self.sheltered = true
    self.physical_addresses = []
  end

   def validate_physical_addresses
    self.physical_addresses = [] unless foster_based
  end

  def validate_before_validation
    return unless foster_based

    self.errors.add(:base, :invalid, message: 'A physical addresses must be entered.') unless physical_addresses.size > 0
  end

end
