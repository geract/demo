require "test_helper"

class NewsletterTest < ActiveSupport::TestCase
  def test_save
    @characteristics = build(:newsletter)

    assert @characteristics.save
  end
end

