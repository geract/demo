# frozen_string_literal: true

module Trackers
  class SegmentTracker
    delegate :track, to: :client

    def initialize
      @segment_key = Rails.application.credentials.segment_key
      @app_url = Rails.application.config_for(:config)['segment']['app_url']
    end

    def identify(user)
      client.identify(
        user_id: user.id,
        traits: {
          name: user.name,
          email: user.email,
          created_at: user.created_at.to_i,
          app_url: app_url
        }
      )
    end

    private

    attr_reader :segment_key, :app_url

    def client
      @client ||= if Rails.env.production?
        SimpleSegment::Client.new({
          write_key: segment_write_key,
          on_error: proc { |_error_code, _error_body, exception, _response|
            raise exception
          }
        })
      else
        SimpleSegment::Client.new(write_key: 'STUBBED', stub: true, logger: Rails.logger)
      end
    end
  end
end
