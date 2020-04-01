# frozen_string_literal: true

module Trackers
  class SegmentTracker
    delegate :track, to: :client

    def initialize
      @segment_key = Rails.application.credentials.segment_key
      @app_url = Rails.application.config_for(:config)[:segment][:front_url]
    end

    def identify(user)
      client.identify(
        user_id: user.id,
        traits: {
          email: user.email,
          app_url: app_url
        }
      )
    end

    private

    attr_reader :segment_key, :app_url

    def client
      @client ||= if Rails.env.production?
        SimpleSegment::Client.new({
          write_key: segment_key,
          on_error: proc { |_error_code, _error_body, exception, _response|
            raise exception
          }
        })
      else
        SimpleSegment::Client.new(write_key: 'STUBBED', stub: true, logger: Rails.logger)
      end
      ## If you are on development and want to receive customer.io notifications
      ## comment the code above, and uncomment the following code:
      # @client ||=
      #   SimpleSegment::Client.new({
      #     write_key: segment_key,
      #     on_error: proc { |_error_code, _error_body, exception, _response|
      #       raise exception
      #     }
      #   })
    end
  end
end
