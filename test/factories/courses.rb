FactoryBot.define do
  factory :course do
    sequence(:name) { |n| CourseConstants.cycled_name(n) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }

    trait :unique do
      sequence(:name) { |n| CourseConstants.unique_name(n) }
    end

    after(:build) do |course|
      image_path = Rails.root.join("test/factories/files/images/courses/#{course.name.parameterize}.png")

      if image_path.exist?
        course.image.attach(
          io: image_path.open,
          filename: "#{course.name.parameterize}.png",
          content_type: 'image/png'
        )
      end
    end
  end
end
