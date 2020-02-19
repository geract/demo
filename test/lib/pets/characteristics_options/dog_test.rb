# frozen_string_literal: true

require 'test_helper'

class Pets::CharacteristicsOptions::DogTest < ActiveSupport::TestCase
  def setup
    @characteristics = Pets::CharacteristicsOptions::Dog.new
  end

  def test_options
    assert @characteristics.options[:sex]
    assert @characteristics.options[:breed]
    assert @characteristics.options[:housed]
    assert @characteristics.options[:age]
  end
end
