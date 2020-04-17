class OrganizationPresenter
  def initialize(org)
    @org = org
  end

  def response
    {
      id: org.id,
      name: org.name,
      description: org.description,
      web_url: org.web_url,
      email: org.email,
      code: org.code,
      address: org.full_address
    }
  end

  private

  attr_reader :org
end