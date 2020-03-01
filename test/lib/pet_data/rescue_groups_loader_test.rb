# frozen_string_literal: true

require 'test_helper'

class PetData::RescueGroups::LoaderTest < ActiveSupport::TestCase
  def setup
    @loader = PetData::RescueGroups::Loader.new
  end

  # def test_perform
  #   stub_request(:post, 'https://api.rescuegroups.org/http/json').
  #     to_return(status: 200, body: { data: build(:rescue_groups_response) }.to_json)

  #   assert_difference 'Pet.count' do
  #     @loader.perform
  #   end
  # end
end
