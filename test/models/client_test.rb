require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  setup do
    @client = Client.new(email: 'new_client@example.com', password: 'password')
  end

  context 'validations' do
    should validate_presence_of(:email)
    should validate_presence_of(:password)
  end

  test 'client active attribute defaults to true' do
    assert @client.active
  end
end
