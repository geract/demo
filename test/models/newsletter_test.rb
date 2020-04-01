require "test_helper"

class NewsletterTest < ActiveSupport::TestCase
  def setup
    @characteristics = build(:newsletter)
  end

  context 'validations' do
    should validate_presence_of(:email)
  end

  def test_save
    assert @characteristics.save
  end
end

