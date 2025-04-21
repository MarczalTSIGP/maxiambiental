require 'test_helper'

class InstructorSearchTest < ActiveSupport::TestCase
  setup do
    @instructor_ana = FactoryBot.create(:instructor, name: 'Ana', email: 'ana@maxiambiental.com')
    @instructor_bia = FactoryBot.create(:instructor, name: 'Bia', email: 'bia@maxiambiental.com')
    @instructor_cia = FactoryBot.create(:instructor, name: 'Cia', email: 'cia@maxiambiental.com')
  end

  test 'search by name' do
    assert_equal [@instructor_ana], Instructor.search('ana')
  end

  test 'search by email' do
    assert_equal [@instructor_bia], Instructor.search('bia@maxiambiental.com')
  end

  test 'search by partial name' do
    assert_includes Instructor.search('an'), @instructor_ana
    assert_not_includes Instructor.search('an'), @instructor_bia
  end

  test 'search is case-insensitive' do
    assert_equal [@instructor_ana], Instructor.search('ANA')
  end

  test 'search ignores accents' do
    instructor = FactoryBot.create(:instructor, name: 'João')

    assert_equal [instructor], Instructor.search('Joao')
  end

  test 'returns distinct results' do
    FactoryBot.create(:instructor, name: 'Ana', email: 'ana2@maxiambiental.com')

    assert_equal 2, Instructor.search('ana').count
    assert_equal 1, Instructor.search('ana@maxiambiental.com').count
  end
end
