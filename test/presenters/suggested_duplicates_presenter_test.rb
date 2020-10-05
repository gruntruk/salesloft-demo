# frozen_string_literal: true

require 'test_helper'

class SuggestedDuplicatesPresenterTest < ActiveSupport::TestCase
  test '#summary will return possible duplicates' do
    people = [
      { email_address: 'john@doe.com' },
      { email_address: 'johnn@doe.com' },
      { email_address: 'john@gmail.com' },
      { email_address: 'njohn@doe.com' },
      { email_address: 'jane@doe.com' }
    ]
    presenter = SuggestedDuplicatesPresenter.new(people)
    results = presenter.summary

    assert_equal %w[john@doe.com johnn@doe.com njohn@doe.com], results.map { |p| p[:email_address] }.sort
  end

  test '#summary will allow for same local part in different domains' do
    people = [
      { email_address: 'john@doe.com' },
      { email_address: 'john@gmail.com' }
    ]
    presenter = SuggestedDuplicatesPresenter.new(people)
    results = presenter.summary

    assert_empty results
  end

  test '#summary will omit results with distance of two or higher' do
    people = [
      { email_address: 'john@doe.com' },
      { email_address: 'johnny@doe.com' }
    ]
    presenter = SuggestedDuplicatesPresenter.new(people)
    results = presenter.summary

    assert_empty results
  end
end
