FactoryBot.define do
  factory :instructor do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    phone { "(#{rand(11..99)}) 9#{rand(1000..9999)}-#{rand(1000..9999)}" }
    resume { "{ \"ops\": [ { \"insert\": \"#{Faker::Lorem.paragraph(sentence_count: 2)}\\n\" } ] }" }
  end
end
