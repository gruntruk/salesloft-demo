# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  def setup
    visit root_url
    assert_selector 'h2', text: 'SalesLoft People View'
  end

  test 'people list will show people results' do
    assert_selector 'table > tbody > tr', count: 25
  end

  test 'people list will show column headers' do
    assert_selector 'th', text: 'Name'
    assert_selector 'th', text: 'Email'
    assert_selector 'th', text: 'Job Title'
  end
end
