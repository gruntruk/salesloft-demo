# frozen_string_literal: true

class PeopleController < ActionController::API
  def index
    response = api_gateway.people(page: params[:page] || 1)
    render json: response
  end

  def frequency_count
    @presenter = CharacterFrequencyPresenter.new(api_gateway.all_people)
    render json: { data: @presenter.summary, success: true }
  end

  def duplicate_suggestions
    @presenter = SuggestedDuplicatesPresenter.new(api_gateway.all_people)
    render json: { data: @presenter.summary, success: true }
  end

  private

  def api_gateway
    @api_gateway ||= SalesLoftApiGateway.new(api_key: ENV['SALESLOFT_API_KEY'])
  end
end
