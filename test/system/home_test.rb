# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  def setup
    visit root_url
    assert_selector 'span.sr-only', text: 'Loading'
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

  test 'will allow opening the frequency count view' do
    click_link 'Frequency Count'
    assert_selector 'span.sr-only', text: 'Loading'

    assert_selector 'th', text: 'Character'
    assert_selector 'th', text: '# Occurrences'
    assert_selector 'caption', text: /\d+ results/i
  end

  test 'will allow opening the duplicate suggestions view' do
    click_link 'Duplicate Suggestions'
    assert_selector 'span.sr-only', text: 'Loading'

    assert_selector 'th', text: 'Name'
    assert_selector 'th', text: 'Email'
    assert_selector 'th', text: 'Job Title'
    assert_selector 'caption', text: '6 results'
  end

  test 'will allow opening the people view' do
    click_link 'People'
    assert_selector 'span.sr-only', text: 'Loading'

    assert_selector 'th', text: 'Name'
    assert_selector 'th', text: 'Email'
    assert_selector 'th', text: 'Job Title'
    assert_selector 'caption', text: '25 results'
  end
end
