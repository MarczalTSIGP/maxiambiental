require 'test_helper'

class Dashboard::AdminTest < ActiveSupport::TestCase
  def setup
    @service = Dashboard::Admin.new
  end

  test 'should returns correct count and growth for last 30 days' do
    FactoryBot.create_list(:client, 3, created_at: 10.days.ago)
    FactoryBot.create_list(:client, 2, created_at: 40.days.ago)

    result = @service.clients_metrics

    assert_equal 3, result[:count]
    assert_in_delta(50.0, result[:growth]) # (3-2)/2 * 100 = 50%
  end

  test 'should returns 0 growth if no previous clients found' do
    FactoryBot.create(:client, created_at: 10.days.ago)

    result = @service.clients_metrics

    assert_equal 0, result[:growth]
  end

  test 'should handles negative growth' do
    FactoryBot.create_list(:client, 2, created_at: 10.days.ago)
    FactoryBot.create_list(:client, 4, created_at: 40.days.ago)

    result = @service.clients_metrics

    assert_in_delta(-50.0, result[:growth]) # (2-4)/4 * 100 = -50%
  end
end
