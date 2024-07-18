require 'support/simplecov'
require 'support/bullet'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    include FactoryBot::Syntax::Methods
    include BulletHelper

    # Add more helper methods to be used by all tests here...

    parallelize_setup do |worker|
      SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}" if ENV['COVERAGE']
    end

    parallelize_teardown do |_worker|
      SimpleCov.result if ENV['COVERAGE']
    end
  end
end
