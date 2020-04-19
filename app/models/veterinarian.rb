# frozen_string_literal: true

class Veterinarian < ApplicationRecord
  has_one :address, class_name: "AdopterAddress", as: :addressable
  belongs_to :adopter_profile

  validates :first_name, :last_name, :email, :phone_number, :address, presence: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

  accepts_nested_attributes_for :address
end
