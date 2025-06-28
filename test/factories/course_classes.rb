FactoryBot.define do
  factory :course_class do
    sequence(:name) { |n| "Turma #{n}-#{Faker::Lorem.characters(number: 2).upcase}" }
    available_slots { 10 }
    start_at { 1.week.from_now.beginning_of_day + 9.hours }
    end_at { start_at + 2.months }
    schedule { '08:00 - 10:00' }
    active { true }

    course
    instructor

    about { Faker::Quote.famous_last_words }
    address { "#{Faker::Address.street_address}, #{Faker::Address.city}" }
    programming { Faker::Quote.famous_last_words }
    acceptance_terms { Faker::Quote.famous_last_words }
  end
end
