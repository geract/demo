require "test_helper"

class InqueryTest < ActiveSupport::TestCase
  def setup
    @inquery = build(:inquery)
  end

  context 'associations' do
    should belong_to(:pet)
  end

  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:phone_number)
    should validate_presence_of(:email)
    should validate_presence_of(:city)
    should validate_presence_of(:state)
  end

  def test_it_can_be_saved
    assert @inquery.save
  end
end
