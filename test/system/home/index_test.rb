# frozen_string_literal: true

require 'application_system_test_case'

module Home
  class IndexTest < ApplicationSystemTestCase
    test 'visiting the home page' do
      visit root_url

      assert_selector 'h1', text: 'Maxiambiental Treinamentos'
    end
  end
end
