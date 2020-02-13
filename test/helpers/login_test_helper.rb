module LoginTestHelpers
  def login_as_admin(admin: create(:admin))
    login_as(admin, scope: :admin)
  end
end
