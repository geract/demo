class OrganizationObjectPresenter
  def self.to_json(org)
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
end
