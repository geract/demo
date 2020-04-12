require "test_helper"

class EmploymentTest < ActiveSupport::TestCase
  setup do
    @adopter = build(:adopter)
    @employment = build(:employment, employmentable: @adopter.profile)
  end

  context 'validations' do
    should validate_presence_of(:status)
    should validate_presence_of(:years)
    should validate_presence_of(:company)
    should validate_presence_of(:address)
  end

  def test_pet_can_be_created
    @employment.save
  end

  def test_must_validate_address_if_retired
    @employment.status ='Retired'
    @employment.save

    assert @employment.without_address?
    assert validate_presence_of(:address)
  end

  def test_must_validate_address_if_un_employed
    @employment.status ='Unemployed'
    @employment.save

    assert @employment.without_address?
    assert validate_presence_of(:address)
  end
end
