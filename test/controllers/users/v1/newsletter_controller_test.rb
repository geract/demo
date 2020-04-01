require 'test_helper'

class Users::V1::NewsletterControllerTest < ActionDispatch::IntegrationTest
  def test_success_on_post_create
    post newsletter_index_url, 
      params: build(:newsletter_params),
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response['newsletter'].present?
  end

  def test_error_on_post_create
    post newsletter_index_url,
      params: {newsletter: {email: ''}},
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response['newsletter'].present?
    assert api_response['errors'].present?
  end
end
