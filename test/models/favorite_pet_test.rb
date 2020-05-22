require "test_helper"

class FavoritePetTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:pet)
    should belong_to(:adopter)
  end
end