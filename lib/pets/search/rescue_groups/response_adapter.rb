class Pets::Search::RescueGroups::ResponseAdapter
  def initialize(item)
    @item = item
  end

  def id
    item['animalID']
  end

  def name
    @name ||= item['animalName'].blank? ? '' : item['animalName'].gsub(/[^a-zA-Z]/, '')
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

  def price
    item['animalAdoptionFee']
  end

  def source
    'RescueGroups'
  end

  def images_url
    @images ||= item['animalPictures'].map do |img| 
                  { 
                    original: img['urlSecureFullsize'], 
                    thumbnail: img['urlSecureThumbnail'] 
                  }
    end  
  end

  def birthdate
    item['animalBirthdate']
  end

  def description
    @dascription ||= ActionController::Base.helpers.strip_tags(item['animalDescription'])
  end

  def size
    item['animalGeneralSizePotential']
  end

  def organization_id
    item['animalOrgID']
  end

  def organization_name
    return '' unless organization
    organization['orgName']
  end

  def organization
    @org ||= RescueGroups::Organization.find(organization_id.to_i).first
  end

  def status
    item['animalStatus']
  end

  def slug
    item['animalID']
  end

  private

  attr_reader :item
end
