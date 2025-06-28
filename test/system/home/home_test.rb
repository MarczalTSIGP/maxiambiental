# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  test 'visiting the home page' do
    visit root_url

    assert_selector 'h1', text: t('home.title')
    assert_selector "a[href='#{courses_path}']", text: t('links.courses')
    assert_selector "a[href='#{course_classes_path}']", text: t('links.classes')
  end

  test 'displaying a hero section' do
    visit root_url

    within '#hero-section' do
      assert_selector 'h1', text: t('home.title')
      assert_selector 'h2', text: t('home.subtitle')
      assert_selector "a[href='#{courses_path}']", text: t('links.explore_our_courses')
    end
  end

  test 'displaying the new classes with open subscription' do
    course_classes = FactoryBot.create_list(:course_class, 3, subscription_status: :open)

    visit root_url

    within '#new-classes' do
      course_classes.each do |course_class|
        assert_selector "li#class-#{course_class.id}", text: course_class.name
        assert_selector "a[href='#{course_class_programming_path(course_class)}']"
        assert_selector "a[href='#{clients_new_enrollment_path(course_class)}']"
      end
    end
  end
end
