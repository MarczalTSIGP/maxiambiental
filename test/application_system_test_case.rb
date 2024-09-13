require 'test_helper'
require 'support/capybara'
require 'support/helpers/capybara_custom_assertions'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include CapybaraCustomAssertions

  driven_by :chrome

  def setup
    super
    Capybara.disable_animation = true
    Capybara.server_host = '0.0.0.0'
    Capybara.app_host = app_host
    Capybara.default_driver = :chrome
    Capybara.javascript_driver = :chrome
  end
end
