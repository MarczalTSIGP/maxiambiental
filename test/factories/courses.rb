FactoryBot.define do
  factory :course do
    name { Faker::Educator.unique.subject }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
