require 'test_helper'

class PetTest < ActiveSupport::TestCase
  def setup
    @pet = build(:pet)
  end

  should validate_presence_of :description
  should validate_presence_of :breed
  should validate_presence_of :sex
  should validate_presence_of :size
  should validate_presence_of :age
  should validate_presence_of :price
  should validate_presence_of :name
end
