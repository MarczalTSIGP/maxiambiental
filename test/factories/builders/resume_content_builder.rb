module ResumeContentBuilder
  SECTION_GENERATORS = {
    profile: lambda {
      generate_section('Perfil Profissional', Faker::Educator.degree)
    },

    experience: lambda {
      generate_section('Experiência', "#{Faker::Job.title} na #{Faker::Company.name}")
    },

    education: lambda {
      generate_section('Formação', "#{Faker::Educator.degree} na #{Faker::Educator.university}")
    }
  }.freeze

  def self.generate(*sections)
    sections.map { |section| SECTION_GENERATORS[section].call }.join
  end

  private_class_method def self.generate_section(title, item)
    "<h1><strong>#{title}</strong></h1><div><br></div><p>#{item}</p><div><br></div>"
  end
end
