# frozen_string_literal: true

class Veterinarian < ApplicationRecord
  has_one :address, class_name: "AdopterAddress", as: :addressable

  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

  accepts_nested_attributes_for :address
end
