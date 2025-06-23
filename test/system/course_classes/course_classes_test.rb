require 'application_system_test_case'

class CourseClassesTest < ApplicationSystemTestCase
  setup do
    @course_classes = FactoryBot.create_list(:course_class, 3)
  end

  test 'displaying all course classes' do
    visit course_classes_path

    within '#course-classes-cards' do
      @course_classes.each do |course_class|
        within "#course-class-#{course_class.id}-card" do
          assert_text course_class.name
          assert_selector "img[alt='#{course_class.name}']"
        end
      end
    end
  end

  test 'displaying course class main details' do
    visit course_class_path(@course_classes.first)

    within '#course-class-main' do
      assert_selector "img[alt='#{@course_classes.first.name}']"
      assert_text @course_classes.first.name
      assert_text @course_classes.first.schedule
    end
  end

  test 'displaying course class details' do
    visit course_class_path(@course_classes.first)

    within '#course-class-about' do
      assert_rich_text @course_classes.first.about
    end
  end

  test 'displaying instructor details' do
    visit course_class_path(@course_classes.first)

    click_on I18n.t('links.instructors')

    within '#course-class-instructor' do
      assert_text @course_classes.first.instructor.name
      assert_selector "img[alt='#{@course_classes.first.instructor.name}']"
      assert_rich_text @course_classes.first.instructor.resume
    end
  end

  test 'displaying class programming' do
    visit course_class_path(@course_classes.first)

    click_on I18n.t('links.schedule')

    within '#course-class-programming' do
      assert_rich_text @course_classes.first.programming
    end
  end

  test 'displaying class acceptance terms' do
    visit course_class_path(@course_classes.first)

    click_on I18n.t('links.terms')

    within '#course-class-terms' do
      assert_rich_text @course_classes.first.acceptance_terms
    end
  end
end
