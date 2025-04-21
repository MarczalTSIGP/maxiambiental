require 'test_helper'

class CourseSearchTest < ActiveSupport::TestCase
  setup do
    @course_a = FactoryBot.create(:course, name: 'Agricultura')
    @course_b = FactoryBot.create(:course, name: 'Biotecnologia')
    @course_p = FactoryBot.create(:course, name: 'Perícia ambiental')
  end

  test 'search by name' do
    assert_equal [@course_b], Course.search('Biotecnologia')
  end

  test 'search by partial name' do
    assert_equal [@course_p], Course.search('ambiental')
  end

  test 'search by non-existent name' do
    assert_empty Course.search('Non-existent')
  end

  test 'search ignores accents' do
    assert_equal [@course_p], Course.search('Pericia')
  end

  test 'search is case-insensitive' do
    assert_equal [@course_p], Course.search('PERiCIA')
  end
end
