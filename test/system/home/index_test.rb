# frozen_string_literal: true

require 'application_system_test_case'

module Home
  class IndexTest < ApplicationSystemTestCase
    test 'visiting the home page' do
      # debugger
      visit root_url

      assert_selector 'h1', text: 'Maxiambiental, a melhor escolha para sua empresa.'
    end
  end
end
