require "test_helper"

class Users::V1::Adopters::SearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adopter = create(:adopter)
    @credentials = @adopter.create_token
    @adopter.save
  end

  def test_update_success
    patch adopters_searches_path,
      params: { search: search_params },
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @adopter.reload

    assert_response :success
    assert @adopter.search.present?
  end

  private

  def search_params
    {
      breed: 'Husky', 
      age: 1 
    }
  end
end
