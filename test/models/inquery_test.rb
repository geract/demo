require "test_helper"

class InqueryTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:phone_number)
    should validate_presence_of(:email)
    should validate_presence_of(:city)
    should validate_presence_of(:state)
  end
  
  def test_it_can_be_saved
    @inquery = build(:inquery)

    assert @inquery.save
  end
end
