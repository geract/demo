require "test_helper"

class Users::V1::InqueriesControllerTest < ActionDispatch::IntegrationTest
  def test_success_create
    post inqueries_url,
      params: build(:inquery_params),
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response['inquery'].present?
    assert api_response['inquery']['email'].present?
  end

  def test_success_error
    post inqueries_url,
      params: build(:inquery_invalid_params),
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response['inquery'].present?
    refute api_response['inquery']['email'].present?
    refute api_response['inquery']['pet_id'].present?
    assert api_response['errors'].present?
  end
end
