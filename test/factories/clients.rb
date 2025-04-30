FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'password' }
    bio { Faker::Quote.fortune_cookie }
    active { true }
    confirmed_at { Time.zone.now }
  end
end
