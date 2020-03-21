class Adopter < User
  store_accessor :settings, :search
  has_many :messages, foreign_key: 'sender_id'
end
