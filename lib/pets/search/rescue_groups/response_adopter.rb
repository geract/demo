class Pets::Search::RescueGroups::ResponseAdopter
  def initialize(item)
    @item = item
  end

  def id
    item['animalID']
  end

  def name
    item['animalName']
  end

  def breed
    item['animalBreed']
  end

  def sex
    item['animalSex']
  end

  def age
    item['animalGeneralAge']
  end

  def location
    item['animalLocationCitystate']
  end

  def fee
    item['animalAdoptionFee']
  end

  def main_image_url
    item['animalPictures'].dig(0, 'urlSecureFullsize')
  end

  def birthdate
    item['animalBirthdate']
  end

  def description
    item['animalDescription']
  end

  def organization_id
    item['animalOrgID']
  end

  def organization_name
    RescueGroups::Organization.find(item['animalOrgID'].to_i).first['orgName'] || ''
  end

  def status
    item['animalStatus']
  end

  private

  attr_reader :item
end