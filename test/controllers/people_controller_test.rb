# frozen_string_literal: true

require 'test_helper'
require 'webmock/minitest'

class PeopleControllerTest < ActionDispatch::IntegrationTest
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

  test 'people#index will succeed' do
    stub_request(:get, 'https://api.salesloft.com/v2/people')
      .with(query: { 'page': '1' })
      .to_return(body: file_fixture_path('people_response_ok.json').read)

    get people_url

    assert_response :success
  end
end
