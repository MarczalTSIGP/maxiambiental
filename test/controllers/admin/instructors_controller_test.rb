require 'test_helper'

class Admin::InstructorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'should get new' do
    get new_admin_instructor_path

    assert_response :success
  end

  test 'should create an instructor' do
    post admin_instructors_path,
         params: { instructor: { email: 'test@test.com',
                                 name: 'Instructor',
                                 phone: '(42) 98425-2615',
                                 resume: '{ ops: [{ insert: Faker::Lorem.paragraph(sentence_count: 2) + "\n" }] }' } }

    assert_redirected_to admin_instructors_path
    assert_equal t('flash_messages.created', model: Instructor.model_name.human), flash[:notice]
  end

  test 'should not create an instructor with invalid attributes' do
    post admin_instructors_path,
         params: { instructor: { email: '',
                                 name: 'In',
                                 phone: '(42) 98425-2615',
                                 resume: '{ ops: [{ insert: Faker::Lorem.paragraph(sentence_count: 2) + "\n" }] }' } }

    assert_response :unprocessable_entity
  end

  test 'should update an instructor' do
    instructor = FactoryBot.create(:instructor)

    patch admin_instructor_path(instructor),
          params: { instructor: { name: 'Instructor 2', phone: '(42) 98425-2615' } }

    assert_redirected_to admin_instructors_path
    assert_equal t('flash_messages.updated', model: Instructor.model_name.human), flash[:notice]
  end

  test 'should not update an instructor with invalid attributes' do
    instructor = FactoryBot.create(:instructor)

    patch admin_instructor_path(instructor),
          params: { instructor: { name: '', phone: '(42) 98425-26' } }

    assert_response :unprocessable_entity
  end

  test 'should get all registered instructors' do
    instructors = FactoryBot.create_list(:instructor, 5)

    get admin_instructors_path

    assert_response :success

    instructors.each do |instructor|
      assert_match instructor.name, @response.body
    end
  end

  test 'should show the instructor resume' do
    instructor = FactoryBot.create(:instructor)

    get admin_instructor_path(instructor)

    assert_response :success
  end
end
