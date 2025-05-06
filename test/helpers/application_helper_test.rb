require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title without param' do
    assert_equal I18n.t('app.name'), full_title
  end

  test 'full title with param' do
    assert_equal "Home | #{I18n.t('app.name')}", full_title('Home')
  end

  test 'full title with nil param' do
    assert_equal I18n.t('app.name'), full_title(nil)
  end
end
