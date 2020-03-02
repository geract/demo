require "test_helper"

class Users::V1::PetsControllerTest < ActionDispatch::IntegrationTest
  def setup
  end

  def test_index
    create(:pet, :complete, name: 'GoodBoy17', status: 'published')
    create(:pet, :complete, name: 'Doge', status: 'published')
    create(:pet, :complete, name: 'Doge', status: 'created')

    get pets_url,
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :success
    binding.pry
  end
end

