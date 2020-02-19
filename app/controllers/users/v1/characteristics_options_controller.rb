class Users::V1::CharacteristicsOptionsController < Users::BaseController

  def index
    render json: options
  end

  private

  def options
    @options ||= Pet::CharacteristicsOptions.perform('dog')
  end
end
