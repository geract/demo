class Users::V1::CharacteristicsOptionsController < Users::BaseController
  def index
    render json: CharacteristicsOptions::IndexPresenter.new(options)
  end

  private

  def options
    @options ||= Pet::CharacteristicsOptions.perform('dog')
  end
end
