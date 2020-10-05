# frozen_string_literal: true

require 'test_helper'
require 'webmock/minitest'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  test 'people#index will succeed' do
    stub_request(:get, 'https://api.salesloft.com/v2/people')
      .with(query: { 'page': '1' })
      .to_return(body: file_fixture_path('people_response_ok.json').read)

    get people_url

    assert_response :success
  end

  test 'collection route' do
    assert_generates '/api/people', controller: 'people', action: 'index'
  end

  test 'people#frequency_count will succeed' do
    payload = file_fixture_json('people_response_ok.json') do |fixture|
      fixture[:metadata][:paging][:total_pages] = 1
    end
    stub_request(:get, 'https://api.salesloft.com/v2/people')
      .with(query: { 'per_page': '100', 'include_paging_counts': true })
      .to_return(body: payload.to_json)

    get frequency_count_people_url

    assert_response :success
  end

  test 'frequency count route' do
    assert_generates '/api/people/frequency_count', controller: 'people', action: 'frequency_count'
  end

  test 'people#suggested_duplicates will succeed' do
    payload = file_fixture_json('people_response_ok.json') do |fixture|
      fixture[:metadata][:paging][:total_pages] = 1
    end
    stub_request(:get, 'https://api.salesloft.com/v2/people')
      .with(query: { 'per_page': '100', 'include_paging_counts': true })
      .to_return(body: payload.to_json)

    get duplicate_suggestions_people_url

    assert_response :success
  end

  test 'duplicates suggestions route' do
    assert_generates '/api/people/duplicate_suggestions', controller: 'people', action: 'duplicate_suggestions'
  end
end
