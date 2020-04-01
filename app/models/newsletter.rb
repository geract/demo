class Newsletter < ApplicationRecord
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end
