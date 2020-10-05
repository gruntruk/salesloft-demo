# frozen_string_literal: true

require 'test_helper'

class CharacterFrequencyPresenterTest < ActiveSupport::TestCase
  setup do
    @people = [{ email_address: 'foo@bar.com' }, { email_address: 'bar@bazz.com' }]
  end

  test '#summary will return counts in descending order' do
    presenter = CharacterFrequencyPresenter.new(@people)

    summary = presenter.summary

    assert_equal ['o', 4], summary.first
    assert_equal ['f', 1], summary.last
  end

  test '#summary will return entry for all distinct characters' do
    presenter = CharacterFrequencyPresenter.new(@people)

    summary = presenter.summary

    assert_equal 10, summary.length
  end

  test '#summary will ignore case when counting occurrences' do
    @people.first[:email_address] = 'FOO@BAR.COM'

    presenter = CharacterFrequencyPresenter.new(@people)
    summary = presenter.summary

    assert_equal ['o', 4], summary.first
    assert_equal ['f', 1], summary.last
  end
end
