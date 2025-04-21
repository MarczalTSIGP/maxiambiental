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
    <<~STRING
      <h1><strong>#{title}</strong></h1>
      <div><br></div>
      <ul>
        #{items.map { |item| "<li>#{item}</li>" }.join}
      </ul>
      <div><br></div>
    STRING
  end
end
