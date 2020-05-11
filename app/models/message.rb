class Message < ApplicationRecord
  belongs_to :senderable, polymorphic: true
  belongs_to :pet_application
end
