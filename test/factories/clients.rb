FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'password' }
    bio { Faker::Quote.fortune_cookie }
    cpf { CpfGenerator.generate }
    phone { Faker::PhoneNumber.numerify('(##) 9####-####') }
    cep { Faker::Address.zip_code }
    city { Faker::Address.city }
    state { Faker::Address.state }
    address { Faker::Address.street_address }
    active { true }
    confirmed_at { Time.zone.now }
  end
end
