# frozen_string_literal: true

class SalesLoftApiGateway
  include HTTParty

  base_uri 'https://api.salesloft.com'

  MAX_PAGE_SIZE = 100

  def initialize(options = {})
    @options = { headers: { 'Authorization': "Bearer #{options.fetch(:api_key)}" }, format: :plain }
  end

  #
  # Retrieves a page of people data
  #
  def people(options = {})
    query = options.slice(:page, :per_page, :include_paging_counts)

    response = self.class.get('/v2/people', @options.merge(query: query))
    raise "Request failed (#{response.code})" unless response.success?

    JSON.parse response, symbolize_names: true
  end

  #
  # Fetches the entire people dataset
  #
  def all_people
    response = people(per_page: MAX_PAGE_SIZE, include_paging_counts: true)
    paging_metadata = response[:metadata][:paging]
    results = response[:data]
    return results unless paging_metadata[:total_pages] > 1

    responses = request_available_pages(paging_metadata)
    responses.each do |people_response|
      raise "Request failed (#{people_response.status_message})" unless people_response.success?

      payload = JSON.parse people_response.body, symbolize_names: true
      results.push(*payload[:data])
    end
    results
  end

  private

  def request_available_pages(paging_metadata)
    hydra = Typhoeus::Hydra.new
    requests = ((paging_metadata[:current_page] + 1)...(paging_metadata[:total_pages] + 1)).map do |page_offset|
      request = Typhoeus::Request.new(self.class.base_uri + '/v2/people', {
                                        params: { page: page_offset, per_page: MAX_PAGE_SIZE },
                                        headers: @options[:headers]
                                      })
      hydra.queue(request)
      request
    end
    hydra.run

    requests.map(&:response)
  end
end
