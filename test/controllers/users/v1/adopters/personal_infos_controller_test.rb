require "test_helper"

class Users::V1::Adopters::PersonalInfosControllerTest < ActionDispatch::IntegrationTest
  def test_show
    @adopter = build(:adopter, :with_personal_info)
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_personal_info_path,
    headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert(api_response)
    assert_equal(api_response['profile']['has_co_adopter'], false)
    assert_equal(api_response['profile']['pronoun'], 'She')
    assert_equal(api_response['profile']['address_attributes']['city'], 'Mountain View')
    assert_equal(api_response['profile']['employment_attributes']['company'], 'PetParent')
    assert_equal(api_response['profile']['employment_attributes']['address_attributes']['state'], 'CA')
    assert_equal(api_response['profile']['pet_info_attributes']['personal']['ideal_pet'], 'Fluffy')
  end

  def test_create_full_personal_info
    @adopter = build(:adopter, :without_pet_info)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_personal_info_path,
      params: build(:personal_info_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.personal_co_adopter?
    assert_equal @profile.address.city, 'New York'
    assert_equal @profile.employment.company, 'Kuski'
    assert_equal @profile.employment.address.zip_code, '94102'
    assert_equal @profile.pet_info.pet_costs, '1000'
    assert_equal @profile.pet_info.ideal_pet, 'Fluffy'
  end

  def test_create_personal_info_without_employment
    @adopter = build(:adopter, :without_pet_info)
    @credentials = @adopter.create_token
    @adopter.save

    params = build(:personal_info_params)
    params[:profile][:employment_attributes][:status] = 'Unemployed'
    params[:profile][:employment_attributes].delete(:address_attributes)

    patch adopters_personal_info_path,
      params: params,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.personal_co_adopter?
    assert_nil @profile.employment.address
    assert_equal @profile.employment.status, 'Unemployed'
    assert @profile.employment.valid?
  end

  def test_update
    @adopter = build(:adopter, :with_personal_final)
    @credentials = @adopter.create_token
    @adopter.save
    params = Users::Adopters::Profile::PersonalInfoPresenter.new(@adopter).as_json
    params[:profile][:has_co_adopter] = false
    params[:profile][:birthday] = Date.today

    patch adopters_personal_info_path,
      params: params,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.personal_final?
    assert @profile.birthday, Date.today
    assert @profile.address
    assert @profile.employment
    assert @profile.employment.address
    assert @profile.pet_info
    assert @profile.pet_info.personal
  end
end
