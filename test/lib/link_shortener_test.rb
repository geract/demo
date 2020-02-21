require 'test_helper'
require 'link_shortener'

class LinkShortenerTest < ActiveSupport::TestCase
  def test_link_shortener_returns_a_short_url_string
    shortener = LinkShortener.new

    short_url = shortener.shorten('httt://www.test.com')

    assert_equal(short_url, 'http://bit.ly/t3sT')
  end
end
