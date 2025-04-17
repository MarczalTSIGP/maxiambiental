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

module ResumeContentBuilder
  SECTION_GENERATORS = {
    profile: lambda {
      generate_section('Perfil Profissional', [
                         Faker::Educator.degree,
                         Faker::Educator.university
                       ])
    },

    experience: lambda {
      generate_section('Experiência', Array.new(2) do
        "#{Faker::Job.title} na #{Faker::Company.name}"
      end)
    },

    education: lambda {
      generate_section('Formação', [
                         "#{Faker::Educator.degree} na #{Faker::Educator.university}",
                         Faker::Lorem.words(number: 4).join(', ')
                       ])
    }
  }.freeze

  def self.generate(*sections)
    sections.map { |section| SECTION_GENERATORS[section].call }.join
  end

  private_class_method def self.generate_section(title, items)
    <<~HTML
      <h1><strong>#{title}</strong></h1>
      <div><br></div>
      <ul>
        #{items.map { |item| "<li>#{item}</li>" }.join}
      </ul>
      <div><br></div>
    HTML
  end
end
