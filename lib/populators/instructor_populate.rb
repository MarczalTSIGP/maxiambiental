class InstructorPopulate < Populators::BasePopulate
  GENDERS = [:male, :female].freeze

  def initialize
    super
    @gender_rotator = GENDERS.cycle
    @image_cache = load_images
  end

  def create
    gender = @gender_rotator.next
    instructor = create_instructor(gender)
    attach_avatar(instructor, gender)
  end

  private

  def create_instructor(gender)
    FactoryBot.create(
      :instructor,
      name: gender == :male ? Faker::Name.male_first_name : Faker::Name.female_first_name
    )
  end

  def load_images
    GENDERS.index_with do |gender|
      Rails.root.glob("test/factories/files/images/users/#{gender}/*.jpeg").sort
    end
  end

  def next_image(gender)
    return if @image_cache[gender].empty?

    @image_cache[gender].rotate!.last
  end

  def attach_avatar(instructor, gender)
    if (image_path = next_image(gender))
      instructor.avatar.attach(
        io: File.open(image_path),
        filename: "#{gender}_#{File.basename(image_path)}",
        content_type: 'image/jpeg'
      )
    end
  rescue Errno::ENOENT
    Rails.logger.error "Image not found for #{gender}"
  end
end
