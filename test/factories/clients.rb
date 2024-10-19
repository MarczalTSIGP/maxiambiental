FactoryBot.define do
  factory :client do
    email { Faker::Internet.unique.email }
    password { 'password' }
  end
end
