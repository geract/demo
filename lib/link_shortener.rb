class LinkShortener
  def initialize
    @client = Bitly::API::Client.new(token: token)
  end

  def shorten(url)
    @short_url ||= if Rails.env.production?
      bitlink = client.shorten(long_url: url)
      bitlink.link
    else
      'http://bit.ly/t3sT'
    end
  end

  private

  attr_reader :client

  def token
    Rails.application.credentials.bitly_token
  end
end
