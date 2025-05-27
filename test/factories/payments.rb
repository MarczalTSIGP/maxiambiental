FactoryBot.define do
  factory :payment do
    user { nil }
    amount { "9.99" }
    status { "MyString" }
    payment_method { "MyString" }
    last4 { "MyString" }
  end
end
