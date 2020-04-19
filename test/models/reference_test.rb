require "test_helper"

class ReferenceTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:adopter_profile)
  end

  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
    should validate_presence_of(:relationship)
  end

  def test_it_can_be_saved
    @adopter = build(:adopter)
    @reference = build(:reference, adopter_profile: @adopter.profile)

    assert @reference.save
  end
end
