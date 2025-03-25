require 'application_system_test_case'

class CoursesSystemTest < ApplicationSystemTestCase
  setup do
    @courses = FactoryBot.create_list(:course, 3)
    @course = @courses.first
  end

  test 'display page header' do
    visit courses_path

    assert_selector '.container h1', text: I18n.t('courses.index.title')
    assert_selector '.container p', text: I18n.t('courses.index.description')
  end

  test 'display courses grid with cards' do
    visit courses_path

    assert_selector '#courses-card'

    within '#courses-card' do
      assert_selector '.group', count: @courses.count
    end
  end

  test 'course card basic content' do
    visit courses_path

    within "#course-#{@course.id}-card" do
      assert_selector "img[alt='#{@course.name}']"
      assert_text @course.name
    end
  end

  test 'course card hover shows description overlay' do
    visit courses_path

    card = find("#course-#{@course.id}-card")
    overlay = card.find('div.absolute.inset-0', visible: false)

    assert_equal '0', overlay.native.css_value('opacity')

    card.hover

    assert_operator overlay.native.css_value('opacity').to_f, :>, 0.5

    within card do
      assert_text @course.description.to_plain_text
    end
  end

  test 'course card hover makes overlay visible' do
    visit courses_path

    using_wait_time(5) do
      card = find("#course-#{@course.id}-card")

      overlay = card.find('div.absolute.inset-0', visible: false)

      card.hover

      assert_predicate overlay, :visible?
    end
  end

  test 'empty state visual elements' do
    Course.destroy_all
    visit courses_path

    within '#courses-card' do
      assert_selector 'img[alt="No Results"]'
      assert_selector 'h3', text: I18n.t('courses.no_results.no_courses_title')
      assert_selector 'p', text: I18n.t('courses.no_results.no_courses_description')
    end
  end

  test 'display course show page' do
    visit course_path(@course)

    assert_selector "img[alt='#{@course.name}']"
    assert_selector 'h1', text: @course.name
    assert_selector '.trix-content', text: @course.description.to_plain_text
  end

  test 'displays the links to more information about the course' do
    visit course_path(@course)

    assert_selector 'button', text: I18n.t('buttons.registration_form')

    within '#tabs' do
      expected_tabs = %w[schedule professionals payments about]

      assert_tabs expected_tabs
    end
  end

  private

  def assert_tabs(expected_tabs)
    expected_tabs.each do |tab|
      translated_tab = I18n.t("links.#{tab}")

      assert_selector "li#tab-#{translated_tab}", text: translated_tab
    end
  end
end
