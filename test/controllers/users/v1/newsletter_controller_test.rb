require 'test_helper'

class Users::V1::NewsletterControllerTest < ActionDispatch::IntegrationTest
  def test_success_on_post_create
    params = attributes_for(:newsletter_params)[:body]
    post newsletter_index_url, 
      params: params,
      headers: headers_v1

    assert_response :created
    assert_equal params[:newsletter][:email], Newsletter.last.email
  end

  def test_error_on_post_create
    post newsletter_index_url,
      params: { newsletter: { email: '' } },
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response['errors'].present?
  end
end
