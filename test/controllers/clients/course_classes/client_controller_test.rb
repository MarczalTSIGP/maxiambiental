require 'test_helper'

class Clients::CourseClasses::ClientControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = FactoryBot.create(:client)
    @course_class = FactoryBot.create(:course_class)
    sign_in @client
  end

  test 'should get edit' do
    get clients_edit_course_class_client_path(@course_class)

    assert_response :success
  end

  test 'should update client with valid parameters' do
    patch clients_update_course_class_client_path(@course_class), params: {
      client: {
        name: 'Novo Nome',
        cpf: '323.733.119-84',
        phone: '(11) 99999-9999'
      }
    }

    assert_redirected_to clients_new_course_class_enrollment_path
    assert_equal 'Novo Nome', @client.reload.name
  end

  test 'should not update client with invalid parameters' do
    patch clients_update_course_class_client_path(@course_class), params: {
      client: {
        name: '',
        cpf: '123'
      }
    }

    assert_response :unprocessable_entity
    assert_select 'p.text-red-600', text: I18n.t('errors.messages.blank', attribute: 'Nome')
    assert_select 'p.text-red-600', text: I18n.t('errors.messages.cpf', attribute: 'CPF')
  end

  test 'should not get edit if not signed in' do
    sign_out @client
    get clients_edit_course_class_client_path(@course_class)

    assert_response :redirect
    assert_redirected_to new_client_session_path
  end
end
