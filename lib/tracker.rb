# frozen_string_literal: true

class Tracker
  include Singleton

  delegate :track, :identify, to: :tracker

  def self.track(user, options = {})
    instance.track(
      options.merge(
        user_id: user.id,
        guid: SecureRandom.uuid
      )
    )
  end

  def self.identify(user, token)
    instance.identify(user, token)
  end

  private

  def tracker
    @tracker ||= Trackers::SegmentTracker.new
  end
end
