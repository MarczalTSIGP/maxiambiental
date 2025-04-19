require 'test_helper'

class SearchableTest < ActiveSupport::TestCase
  setup do
    @instructor_ana = FactoryBot.create(:instructor, name: 'Ana', email: 'ana@maxiambiental.com')
    @instructor_bia = FactoryBot.create(:instructor, name: 'Bia', email: 'bia@maxiambiental.com')
    @instructor_cia = FactoryBot.create(:instructor, name: 'Cia', email: 'cia@maxiambiental.com')
  end

  test 'empty search returns all' do
    assert_equal Instructor.all.to_a, Instructor.search('')
  end

  test 'search across multiple fields' do
    instructor = FactoryBot.create(:instructor, name: 'Carlos', email: 'carlos@empresa.com')

    assert_equal [instructor], Instructor.search('empresa')
  end

  test 'sanitize special characters in search term' do
    assert_nothing_raised do
      Instructor.search('%@_')
    end
  end

  test 'returns distinct results' do
    FactoryBot.create(:instructor, name: 'Ana', email: 'ana2@maxiambiental.com')

    assert_equal 2, Instructor.search('ana').count
    assert_equal 1, Instructor.search('ana@maxiambiental.com').count
  end
end
