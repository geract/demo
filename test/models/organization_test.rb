require "test_helper"

describe Organization do

  test 'must_have_a_physical_address' do
    @organization = FactoryBot.create(:organization)
    @physical_address = FactoryBot.create(:physical_address)

    assert_equal 'petparent', @physical_address.name
  end

  def initialize_organization
    @organization = FactoryBot.create(:organization)
  end
end
