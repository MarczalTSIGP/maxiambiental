require "test_helper"

class InstructorTest < ActiveSupport::TestCase
  setup do
    FactoryBot.create(:instructor)
  end
  
  context 'validations' do    
    should validate_presence_of(:name)
    should validate_length_of(:name).is_at_least(3)
    
    should validate_presence_of(:phone)
    
    should validate_presence_of(:email)
    should validate_uniqueness_of(:email)

    should validate_presence_of(:resume)
  end

  test 'should have one attached avatar' do
    instructor = FactoryBot.create(:instructor)
    assert instructor.avatar.is_a?(ActiveStorage::Attached::One), 'Avatar should be attached'
  end

  test 'phone format should be valid' do
    instructor = Instructor.new(name: 'Test', 
                                email: 'test@example.com', 
                                phone: '(11) 98765-4321',
                                resume: Faker::HTML.paragraph)

    assert instructor.valid?, 'Phone format should be valid'

    instructor.phone = '1234-abc-567'
    assert_not instructor.valid?, 'Phone format should be invalid'
  end

  test 'email format should be valid' do
    instructor = Instructor.new(name: 'Test', 
                                email: 'valid@example.com', 
                                phone: '(11) 98765-4321',
                                resume: Faker::HTML.paragraph)

    assert instructor.valid?, 'Email format should be valid'

    instructor.email = 'invalid-email'
    assert_not instructor.valid?, 'Email format should be invalid'
  end
end
