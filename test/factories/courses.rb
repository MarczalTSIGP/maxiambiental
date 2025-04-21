FactoryBot.define do
  factory :course do
    sequence(:name) { |n| CourseConstants.cycled_name(n) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }

    trait :unique do
      sequence(:name) { |n| CourseConstants.unique_name(n) }
    end
  end
end
