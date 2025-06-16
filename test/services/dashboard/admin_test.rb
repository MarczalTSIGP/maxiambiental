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

  test 'should the top courses returns courses ordered by enrollment count' do
    course1 = FactoryBot.create(:course)
    course2 = FactoryBot.create(:course)

    class1 = FactoryBot.create(:course_class, course: course1, subscription_status: :open)
    class2 = FactoryBot.create(:course_class, course: course2, subscription_status: :open)

    FactoryBot.create_list(:enrollment, 3, course_class: class1)
    FactoryBot.create_list(:enrollment, 5, course_class: class2)

    top_courses = @service.top_courses

    assert_equal course2.id, top_courses.first.id
    assert_equal course1.id, top_courses.second.id
  end

  test 'should the top courses limits to 5 results' do
    6.times do |i|
      course = FactoryBot.create(:course)
      course_class = FactoryBot.create(:course_class, course: course, subscription_status: :open)
      FactoryBot.create_list(:enrollment, i + 1, course_class: course_class)
    end

    top_courses = @service.top_courses
    expected_ids = Course.last(5).map(&:id).reverse

    assert_equal expected_ids, top_courses.map(&:id)
    assert_equal 5, top_courses.size
  end

  test 'should the top clients returns clients ordered by enrollment count' do
    client1 = FactoryBot.create(:client)
    client2 = FactoryBot.create(:client)

    class1 = FactoryBot.create(:course_class, subscription_status: :open)
    class2 = FactoryBot.create(:course_class, subscription_status: :open)

    FactoryBot.create(:enrollment, client: client1, course_class: class1)
    FactoryBot.create(:enrollment, client: client1, course_class: class2)
    FactoryBot.create(:enrollment, client: client2, course_class: class2)

    top_clients = @service.top_clients

    assert_equal client1.id, top_clients.first.id
    assert_equal client2.id, top_clients.second.id
  end

  test 'should the top clients limits to 5 results' do
    6.times do |i|
      client = FactoryBot.create(:client)
      course_class = FactoryBot.create(:course_class, subscription_status: :open)
      FactoryBot.create(:enrollment, client: client, course_class: course_class)
    end

    assert_equal 5, @service.top_clients.to_a.size
  end
end
