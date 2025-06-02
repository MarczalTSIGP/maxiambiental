FactoryBot.define do
  factory :payment do
    status { Payment.statuses.keys.sample }
    payment_method { 'credit_card' }

    client
    enrollment
  end
end
