# frozen_string_literal: true

module Trackers
  class SegmentTracker
    delegate :track, to: :client

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

      p ">>>>>>>>>>>>>>>>>>> segment_tracker #{user}"

      # if (organization = user.organization).present?
      #   client.group(
      #     user_id: user.id,
      #     group_id: organization.id,
      #     traits: {
      #       name: organization.name
      #     }
      #   )
      # end
    end

    private

    def app_url
      "http://localhost:3000/"
    end

    def credentials
      Rails.application.credentials[ENV.fetch('APP_ENV', 'staging').to_sym]
    end

    def client
      @client ||= SimpleSegment::Client.new({
                    write_key: segment_write_key,
                    on_error: proc { |_error_code, _error_body, exception, _response|
                      raise exception
                    }
                  })
                  # else
                  #   SimpleSegment::Client.new(write_key: 'STUBBED', stub: true, logger: Rails.logger)
                  # end
    end

    def segment_write_key
      "Ef0N8TZq18gTJorqaohklN8SiNsXCs9Y"
    end
  end
end
