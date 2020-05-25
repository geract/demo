require "test_helper"

class Users::V1::InqueriesControllerTest < ActionDispatch::IntegrationTest
  def test_success_create
    params = build(:inquery_params)
    post inqueries_url,
      params: params,
      headers: headers_v1

    assert_response :created
    assert_equal params['inquery']['email'], Inquery.last.email
  end

  def test_success_error
    post inqueries_url,
      params: build(:inquery_invalid_params),
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response['errors'].present?
  end
end
