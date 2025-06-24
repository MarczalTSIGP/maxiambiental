FactoryBot.define do
  factory :enrollment do
    category { Enrollment.categories.values.sample }
    terms_accepted { true }
    referral_source { Enrollment.referral_sources.values.sample }

    client
    course_class { FactoryBot.create(:course_class, subscription_status: :open) }

    after(:create) do |enrollment|
      FactoryBot.create(:payment, enrollment: enrollment, client: enrollment.client)
    end
  end
end
