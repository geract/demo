class Organizations::Search::RescueGroups::ResponseAdapter
  def initialize(item)
    @item = item
  end

  def id
    item['orgID']
  end

  def name
    item['orgName']
  end

  def description
    item['orgAbout']
  end

  def web_url
    item['orgWebsiteUrl']
  end

  def email
    item['orgEmail']
  end

  def code
    item['orgPostalcode']
  end

  def full_address
    "#{item['orgAddress']}, #{item['orgCity']}, #{item['orgCountry']}"
  end

  private

  attr_reader :item
end
