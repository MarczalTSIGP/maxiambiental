class CourseClassesPopulate < Populators::BasePopulate
  def create
    return [] unless Course.any?

    course = Course.all.sample

    create_class(course)
    create_class(course, subscription_status: :closed)
    create_class(course, subscription_status: :coming_soon)
  end

  private

  def create_class(course, subscription_status: :open)
    FactoryBot.create(:course_class,
                      course: course,
                      instructor: Instructor.all.sample,
                      subscription_status: subscription_status,
                      name: "#{course.name} - #{Faker::Lorem.characters(number: 2).upcase}")
  end
end
