class InstructorPopulate < Populators::BasePopulate
  @male_counter = 2
  @female_counter = 1

  class << self
    attr_accessor :male_counter, :female_counter
  end

  def create
    male
    female
  end

  private

  def male
    instructor = FactoryBot.create(:instructor, name: Faker::Name.male_first_name)
    attach_avatar(instructor, 'male')
  end

  def female
    instructor = FactoryBot.create(:instructor, name: Faker::Name.female_first_name)
    attach_avatar(instructor, 'female')
  end

  def next_number(gender)
    if gender == 'male'
      number = self.class.male_counter
      self.class.male_counter += 2
    else
      number = self.class.female_counter
      self.class.female_counter += 2
    end
    number
  end

  def build_attachment(instructor, image_path)
    instructor.avatar.attach(
      io: File.open(image_path),
      filename: "avatar_#{instructor.id}.jpeg",
      content_type: 'image/jpeg'
    )
  end

  def attach_avatar(instructor, gender)
    number = next_number(gender)
    image_path = Rails.root.join("test/factories/files/images/users/#{gender}/#{number}.jpeg")
    build_attachment(instructor, image_path)
  rescue Errno::ENOENT
    Rails.logger.error "Arquivo não encontrado: #{image_path}. Pulando..."
  end
end
