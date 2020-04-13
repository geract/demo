# frozen_string_literal: true

class Reference < ApplicationRecord
  RELATIONSHIPS = %w[Parent Sibling Family Friend Neighbor Coworker].freeze

  belongs_to :adopter_profile, class_name: 'AdopterProfile'

  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :relationship, presence: true, inclusion: RELATIONSHIPS
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end
