require "test_helper"

class Users::V1::OrganizationsControllerTest < ActionDispatch::IntegrationTest
  def setup
  end

  def test_show
    skip
    api_key = Rails.application.credentials.rescue_groups_key

    stub_request(:post, "https://api.rescuegroups.org/http/json").
          with(
             body: "{\"objectAction\":\"publicView\",\"objectType\":\"orgs\",\"fields\":[\"orgAbout\",\"orgAdoptionProcess\",\"orgAdoptionUrl\",\"orgCommonapplicationAccept\",\"orgDonationUrl\",\"orgEmail\",\"orgFacebookUrl\",\"orgFax\",\"orgID\",\"orgLocation\",\"orgAddress\",\"orgCity\",\"orgCountry\",\"orgLocationDistance\",\"orgPostalcode\",\"orgState\",\"orgPlus4\",\"orgMeetPets\",\"orgName\",\"orgPhone\",\"orgServeAreas\",\"orgServices\",\"orgSponsorshipUrl\",\"orgType\",\"orgWebsiteUrl\"],\"values\":[{\"orgID\":16}],\"apikey\":\"#{api_key}\"}").
          to_return(status: 200, body: { data: [build(:rescue_groups_organization_response)] }.to_json)

    stub_request(:post, "https://api.rescuegroups.org/http/json").
          with(
            body: "{\"objectAction\":\"publicSearch\",\"objectType\":\"animals\",\"search\":{\"resultStart\":0,\"resultLimit\":20,\"resultSort\":\"breedName\",\"resultOrder\":\"asc\",\"calcFoundRows\":\"Yes\",\"filters\":[{\"fieldName\":\"animalSpecies\",\"operation\":\"equal\",\"criteria\":\"Dog\"}],\"fields\":[\"animalID\",\"animalOrgID\",\"animalActivityLevel\",\"animalAdoptionFee\",\"animalAltered\",\"animalAvailableDate\",\"animalBirthdate\",\"animalBirthdateExact\",\"animalBreed\",\"animalCoatLength\",\"animalColor\",\"animalColorID\",\"animalColorDetails\",\"animalCourtesy\",\"animalDeclawed\",\"animalDescription\",\"animalDescriptionPlain\",\"animalDistinguishingMarks\",\"animalEarType\",\"animalEnergyLevel\",\"animalExerciseNeeds\",\"animalEyeColor\",\"animalFence\",\"animalFound\",\"animalFoundDate\",\"animalFoundPostalcode\",\"animalGeneralAge\",\"animalGeneralSizePotential\",\"animalGroomingNeeds\",\"animalHousetrained\",\"animalIndoorOutdoor\",\"animalKillDate\",\"animalKillReason\",\"animalLocation\",\"animalLocationCitystate\",\"animalMicrochipped\",\"animalMixedBreed\",\"animalName\",\"animalSpecialneeds\",\"animalSpecialneedsDescription\",\"animalNeedsFoster\",\"animalNewPeople\",\"animalNotHousetrainedReason\",\"animalObedienceTraining\",\"animalOKWithAdults\",\"animalOKWithCats\",\"animalOKWithDogs\",\"animalOKWithKids\",\"animalOwnerExperience\",\"animalPattern\",\"animalPatternID\",\"animalAdoptionPending\",\"animalPrimaryBreed\",\"animalPrimaryBreedID\",\"animalRescueID\",\"animalSearchString\",\"animalSecondaryBreed\",\"animalSecondaryBreedID\",\"animalSex\",\"animalShedding\",\"animalSizeCurrent\",\"animalSizePotential\",\"animalSizeUOM\",\"animalSpecies\",\"animalSpeciesID\",\"animalSponsorable\",\"animalSponsors\",\"animalSponsorshipDetails\",\"animalSponsorshipMinimum\",\"animalStatus\",\"animalStatusID\",\"animalSummary\",\"animalTailType\",\"animalThumbnailUrl\",\"animalUptodate\",\"animalUpdatedDate\",\"animalUrl\",\"animalVocal\",\"animalYardRequired\",\"animalAffectionate\",\"animalApartment\",\"animalCratetrained\",\"animalDrools\",\"animalEagerToPlease\",\"animalEscapes\",\"animalEventempered\",\"animalFetches\",\"animalGentle\",\"animalGoodInCar\",\"animalGoofy\",\"animalHasAllergies\",\"animalHearingImpaired\",\"animalHypoallergenic\",\"animalIndependent\",\"animalIntelligent\",\"animalLap\",\"animalLeashtrained\",\"animalNeedsCompanionAnimal\",\"animalNoCold\",\"animalNoFemaleDogs\",\"animalNoHeat\",\"animalNoLargeDogs\",\"animalNoMaleDogs\",\"animalNoSmallDogs\",\"animalObedient\",\"animalOKForSeniors\",\"animalOKWithFarmAnimals\",\"animalOlderKidsOnly\",\"animalOngoingMedical\",\"animalPlayful\",\"animalPlaysToys\",\"animalPredatory\",\"animalProtective\",\"animalSightImpaired\",\"animalSkittish\",\"animalSpecialDiet\",\"animalSwims\",\"animalTimid\",\"fosterEmail\",\"fosterFirstname\",\"fosterLastname\",\"fosterName\",\"fosterPhoneCell\",\"fosterPhoneHome\",\"fosterSalutation\",\"locationAddress\",\"locationCity\",\"locationCountry\",\"locationUrl\",\"locationName\",\"locationPhone\",\"locationState\",\"locationPostalcode\",\"animalPictures\",\"animalVideos\",\"animalVideoUrls\"]},\"apikey\":\"#{api_key}\"}").
          to_return(status: 200, body: { data: build(:rescue_groups_response) }.to_json)

    get organization_url(id: '16'),
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :success
    
    assert_equal '16', api_response['organization']['id']
    assert_equal 'Animal Relief Fund', api_response['organization']['name']
    assert_equal 'description', api_response['organization']['description']
    assert_equal 'webUrl', api_response['organization']['webUrl']
    assert_equal 'info@animalrelieffund.org', api_response['organization']['email']
    assert_equal '20636', api_response['organization']['code']
    assert_equal 'P.O. Box 184, Hollywood, United States', api_response['organization']['address']
    assert_equal '320', api_response['organization']['pets'][0]['id']
    assert_equal 'Corky', api_response['organization']['pets'][0]['name']
    assert_equal 'Male', api_response['organization']['pets'][0]['sex']
    assert_equal 'Domestic Short Hair', api_response['organization']['pets'][0]['breed']
    assert_equal 'Young', api_response['organization']['pets'][0]['age']
    assert_equal 'Bowie, MD', api_response['organization']['pets'][0]['location']
    assert_equal 'https://s3.amazonaws.com/filestore.rescuegroups.org/13/pictures/animals/0/320/181_350x216.jpg', api_response['organization']['pets'][0]['image']
  end
end
