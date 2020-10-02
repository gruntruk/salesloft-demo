# frozen_string_literal: true

require 'test_helper'

class SalesLoftApiGatewayTest < ActiveSupport::TestCase
  def file_fixture_path(file)
    Rails.root.join("test/fixtures/files/#{file}")
  end

  setup do
    @api = SalesLoftApiGateway.new(api_key: SecureRandom.uuid)
  end

  test 'will throw given missing api_key option' do
    assert_raise KeyError do
      SalesLoftApiGateway.new
    end
  end

  test 'will authenticate with provided API key' do
    stub_request(:any, 'https://api.salesloft.com/v2/people')
      .with(headers: { 'Authorization': 'Bearer secret' })
      .to_return(body: {}.to_json)

    SalesLoftApiGateway.new(api_key: 'secret').people
  end

  test 'will fetch people data' do
    stub_request(:get, 'https://api.salesloft.com/v2/people')
      .to_return(body: file_fixture_path('people_response_ok.json').read)

    response = @api.people

    assert response.success?
  end

  test 'will fetch specific page of people data' do
    stub_request(:get, 'https://api.salesloft.com/v2/people')
      .with(query: hash_including({ 'page': '2' }))
      .to_return(body: file_fixture_path('people_response_ok.json').read)

    response = @api.people(page: 2)

    assert response.success?
  end

  test 'will throw when people data request fails' do
    stub_request(:get, 'https://api.salesloft.com/v2/people')
      .to_return(body: file_fixture_path('people_response_unauthorized.json'), status: 401)

    assert_raise RuntimeError do
      @api.people
    end
  end

  test 'will return people data' do
    stub_request(:get, 'https://api.salesloft.com/v2/people')
      .to_return(body: file_fixture_path('people_response_ok.json').read)

    response = @api.people

    assert_not response['data'].empty?
  end

  test 'will return people metadata' do
    stub_request(:get, 'https://api.salesloft.com/v2/people')
      .to_return(body: file_fixture_path('people_response_ok.json').read)

    response = @api.people

    assert response['metadata'].present?
  end
end
