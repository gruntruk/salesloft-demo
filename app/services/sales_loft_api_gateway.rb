# frozen_string_literal: true

class SalesLoftApiGateway
  include HTTParty

  base_uri 'https://api.salesloft.com'

  def initialize(options = {})
    @options = { headers: { 'Authorization': "Bearer #{options.fetch(:api_key)}" } }
  end

  def people(options = {})
    response = self.class.get('/v2/people', @options.merge(query: options))
    raise "Request failed (#{response.code})" unless response.success?

    response
  end
end
