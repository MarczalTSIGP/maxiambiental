FactoryBot.define do
  factory :payment do
    payment_method { 'credit_card' }

    client
    enrollment
  end
end
