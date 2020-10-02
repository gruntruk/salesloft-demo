# frozen_string_literal: true

class PeopleController < ActionController::API
  def index
    response = api_gateway.people(page: params[:page])
    render json: response
  end

  private

  def api_gateway
    @api_gateway ||= SalesLoftApiGateway.new(api_key: ENV['SALESLOFT_API_KEY'])
  end
end
