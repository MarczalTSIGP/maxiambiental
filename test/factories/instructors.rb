FactoryBot.define do
  factory :instructor do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.numerify('(##) 9####-####') }

    transient do
      resume_sections { [:profile, :experience, :education] }
    end

    after(:build) do |instructor, evaluator|
      instructor.resume.body = ResumeContentBuilder.generate(*evaluator.resume_sections)
    end
  end
end
