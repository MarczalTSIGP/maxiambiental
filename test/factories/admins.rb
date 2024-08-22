FactoryBot.define do
  factory :admin do
    email { "admin@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
