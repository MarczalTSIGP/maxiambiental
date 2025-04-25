FactoryBot.define do
  factory :course do
    sequence(:name) { |n| CourseConstants.cycled_name(n) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }

    trait :unique do
      sequence(:name) { |n| CourseConstants.unique_name(n) }
    end

    after(:build) do |course|
      course.image.attach(
        io: Rails.root.join("test/factories/files/images/courses/#{course.name.parameterize}.png").open,
        filename: 'course.png',
        content_type: 'image/png'
      )
    end
  end
end
