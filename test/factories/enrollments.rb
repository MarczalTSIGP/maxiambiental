FactoryBot.define do
  factory :enrollment do
    category { Enrollment.categories.values.sample }
    terms_accepted { true }
    referral_source { Enrollment.referral_sources.values.sample }

    client
    course_class
  end
end
