class Adopter < User
  has_one :profile, class_name: 'AdopterProfile', foreign_key: 'user_id'

  has_many :messages, foreign_key: 'sender_id'
  has_many :searches, class_name: 'Search', foreign_key: 'user_id'
  has_and_belongs_to_many :favorite_pets, -> { distinct }, foreign_key: 'user_id', class_name: 'Pet',  join_table: 'favorites' do
    def <<(*items)
      super(items)
    rescue ActiveRecord::RecordNotUnique
      false
    end
  end

  accepts_nested_attributes_for :profile

  validates :password, presence: true, if: :password_required?

  store_accessor :settings, :search
  delegate :address, :employment, to: :profile
end
