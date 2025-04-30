module CourseConstants
  COURSE_NAMES = [
    'Crédito Rural - Elaboração de Projetos Agropecuários',
    'Fiscalização Ambiental',
    'EIA/RIMA - Estudo e Relatório de Impacto Ambiental',
    'Licenciamento Ambiental',
    'Elaboração de Projetos de Recuperação de Áreas Degradadas',
    'Perícia Ambiental',
    'Gestão de Resíduos Industriais',
    'Sistema de Gestão Ambiental',
    'Direito Ambiental'
  ].freeze

  class << self
    def cycled_name(index)
      COURSE_NAMES[index % COURSE_NAMES.size]
    end

    def unique_name(index)
      "#{cycled_name(index)} ##{index + 1}"
    end
  end
end
