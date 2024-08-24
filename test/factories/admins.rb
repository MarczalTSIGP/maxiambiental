FactoryBot.define do
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password" }
    master { false }
    bio { Faker::Lorem.paragraph }
    avatar { Faker::Avatar.image }
    active { true }
  end
end
