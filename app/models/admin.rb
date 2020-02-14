class Admin < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  has_many :organizations
end
