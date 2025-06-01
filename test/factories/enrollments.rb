FactoryBot.define do
  factory :enrollment do
    category { Enrollment.categories.keys.sample }
    terms_accepted { true }
    referral_source { Enrollment.referral_sources.keys.sample }

    client
    course_class
  end
end
