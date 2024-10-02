FactoryBot.define do
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'password' }
    master { false }
    active { true }
  end
end
