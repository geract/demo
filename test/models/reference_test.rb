require "test_helper"

class ReferenceTest < ActiveSupport::TestCase
  setup do
    @reference = build(:reference)
  end

  context 'associations' do
    should belong_to(:application)
  end

  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
    should validate_presence_of(:phone_number)
    should validate_presence_of(:relationship)
  end

  def test_it_can_be_saved
    assert @reference.save
  end
end
