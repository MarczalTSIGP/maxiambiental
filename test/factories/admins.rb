FactoryBot.define do
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    master { false }
    avatar { Faker::Avatar.image }
    active { true }
  end
end
