# frozen_string_literal: true

class Reference < ApplicationRecord
  RELATIONSHIPS = %w[Parent Sibling Family Friend Neighbor Coworker].freeze

  belongs_to :application, class_name: 'PetApplication'

  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :relationship, presence: true, inclusion: RELATIONSHIPS
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end
