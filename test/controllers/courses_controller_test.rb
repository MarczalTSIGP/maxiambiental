require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course1 = FactoryBot.create(:course, name: 'Z Course')
    @course2 = FactoryBot.create(:course, name: 'A Course')
    @course1.image.attach(io: File.open('test/fixtures/files/avatar.png'), filename: 'avatar.png')
  end

  test 'should get index' do
    get courses_path

    assert_response :success
  end

  test 'should load courses in correct order' do
    get courses_path

    assert_select "#course-#{@course2.id}-card h3", text: 'A Course'
    assert_select "#course-#{@course1.id}-card h3", text: 'Z Course'
  end

  test 'should display course information' do
    get courses_path

    card_id = "#course-#{@course1.id}-card"

    assert_select "#{card_id} h3", text: @course1.name
    assert_select "#{card_id} p", text: @course1.description
    assert_select "img[src$='avatar.png']", count: 1
  end
end
