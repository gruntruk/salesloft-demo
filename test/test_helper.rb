# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Add more helper methods to be used by all tests here...

    def file_fixture_path(file)
      Rails.root.join("test/fixtures/files/#{file}")
    end

    def file_fixture_json(file)
      payload = JSON.decode(file_fixture_path(file).read).with_indifferent_access
      if block_given?
        yield payload
      end
      payload
    end
  end
end
