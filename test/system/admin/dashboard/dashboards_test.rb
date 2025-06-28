require 'application_system_test_case'

class Dashboard::DashboardsTest < ApplicationSystemTestCase
  setup do
    @clients = FactoryBot.create_list(:client, 5)

    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'visiting the index' do
    visit admin_root_path

    assert_selector '#stats'
    assert_selector '#tables'
  end

  test 'displaying courses stats' do
    visit admin_root_path

    within '#courses_stats' do
      assert_selector '#count', text: '20'
      assert_selector '#growth', text: '+12.6%'
      assert_selector '#text', text: I18n.t('admin.dashboard.index.stats.courses')
    end
  end

  test 'displaying clients stats' do
    FactoryBot.create_list(:client, 2, created_at: 40.days.ago)

    visit admin_root_path

    within '#clients_stats' do
      assert_selector '#count', text: @clients.count
      assert_selector '#growth', text: '+150.0%'
      assert_selector '#text', text: I18n.t('admin.dashboard.index.stats.clients')
    end
  end

  test 'displaying subscriptions stats' do
    FactoryBot.create_list(:enrollment, 2, created_at: 40.days.ago)
    FactoryBot.create_list(:enrollment, 4)

    visit admin_root_path

    within '#subscriptions_stats' do
      assert_selector '#count', text: '4'
      assert_selector '#growth', text: '+100.0%'
      assert_selector '#text', text: I18n.t('admin.dashboard.index.stats.subscriptions')
    end
  end

  test 'displaying top clients table' do
    create_enrollments

    visit admin_root_path

    within '#top-clients' do
      @clients.each do |client|
        assert_selector "#client-#{client.id}", text: client.name
        assert_selector "#client-#{client.id}", text: client.email
      end
    end
  end

  test 'displaying top courses table' do
    create_enrollments

    visit admin_root_path

    within '#top-courses tbody' do
      Course.find_each do |course|
        assert_selector "#course-#{course.id}", text: course.name
      end
    end
  end

  private

  def create_enrollments
    @clients.each do |client|
      FactoryBot.create(:enrollment, client: client)
    end
  end
end
