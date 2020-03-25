require 'test_helper'

class AdopterTest < ActiveSupport::TestCase
  should have_and_belong_to_many(:favorite_pets)
end
