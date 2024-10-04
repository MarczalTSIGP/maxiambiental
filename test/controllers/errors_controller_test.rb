require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  def test_should_get_not_found
    get "/404"
    assert_response :not_found
  end

  def test_should_get_internal_server_error
    get "/500"
    assert_response :internal_server_error
  end
end
