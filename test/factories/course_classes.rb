FactoryBot.define do
  factory :course_class do
    sequence(:name) { |n| "Turma #{n}-#{Faker::Lorem.characters(number: 2).upcase}" }
    start_at { 1.week.from_now.beginning_of_day + 9.hours }
    end_at { start_at + 2.months }
    period { '08:00 - 10:00' }
    active { true }
    address { Faker::Address.street_address }
    city { Faker::Address.city }

    course
    instructor

    about { Faker::Lorem.paragraph(sentence_count: 3) }
    programming { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
