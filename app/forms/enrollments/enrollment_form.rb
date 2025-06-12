class Enrollments::EnrollmentForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  delegate :categories, to: :Enrollment

  delegate :referral_sources, to: :Enrollment

  attr_accessor :category, :referral_source, :notes, :terms_accepted, :previous_participation

  validates :category, presence: true
  validates :referral_source, presence: true
  validates :terms_accepted, presence: true

  # validates :category, presence: true, inclusion: { in: :categories }
  validates :terms_accepted, acceptance: true
  # validates :referral_source, presence: true, inclusion: { in: :referral_sources }

  delegate :model_name, to: :Enrollment

  def self.human_attribute_name(attribute, _options = {})
    Enrollment.human_attribute_name(attribute)
  end

  def save!(client, course_class)
    client.enrollments.create!(attributes.merge(course_class: course_class))
  end

  def attributes
    {
      category: category,
      referral_source: referral_source,
      notes: notes,
      terms_accepted: terms_accepted
    }
  end
end
