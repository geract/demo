class Users::InqueryPresenter
  def initialize(inquery)
    @inquery = inquery
  end

  def response
    {
      id: inquery.id,
      first_name: inquery.first_name,
      last_name: inquery.last_name,
      phone_number: inquery.email,
      email: inquery.email,
      city: inquery.city,
      state: inquery.state,
      reasons: inquery.reasons,
      pet_id: inquery.pet_id
    }.compact
  end

  private

  attr_reader :inquery
end
