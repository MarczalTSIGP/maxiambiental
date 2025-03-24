require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_z = FactoryBot.create(:course, name: 'Z Course')
    @course_a = FactoryBot.create(:course, name: 'A Course')
    @course_z.image.attach(io: File.open('test/fixtures/files/avatar.png'), filename: 'avatar.png')
  end

  test 'should get index' do
    get courses_path

    assert_response :success
  end

  test 'should load courses in correct order' do
    get courses_path

    assert_select "#course-#{@course_a.id}-card h1", text: 'A Course'
    assert_select "#course-#{@course_z.id}-card h1", text: 'Z Course'
  end

  test 'should display course information' do
    get courses_path

    card_id = "#course-#{@course_z.id}-card"

    assert_select "#{card_id} h1", text: @course_z.name
    assert_select "#{card_id} .prose", text: @course_z.description.to_plain_text
    assert_select "img[src$='avatar.png']", count: 1
  end
end
