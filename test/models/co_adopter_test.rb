require 'test_helper'

class CoAdopterTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:adopter_profile)
  end
  
  context 'validations' do
    should validate_presence_of(:email)
    should validate_presence_of(:phone_number)
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
  end
  
  def test_is_valid
    @adopter = build(:adopter)
    @co_adopter = build(:co_adopter, adopter_profile: @adopter.profile)
    assert @co_adopter.save
  end
end
