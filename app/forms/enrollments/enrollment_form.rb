class Enrollments::EnrollmentForm < BaseForm
  delegate :categories, to: :Enrollment
  delegate :referral_sources, to: :Enrollment

  attr_accessor :category, :referral_source, :notes, :terms_accepted, :previous_participation

  validates :terms_accepted, acceptance: true

  validates :category,
            presence: true,
            inclusion: { in: ->(form) { form.categories.keys.map(&:to_s) } }

  validates :referral_source,
            presence: true,
            inclusion: { in: ->(form) { form.referral_sources.keys.map(&:to_s) } }

  def create(client, course_class)
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

  def params
    [:category, :referral_source, :notes, :terms_accepted]
  end

  def category_options
    categories.keys.map do |key|
      [I18n.t("activerecord.attributes.enrollment.categories.#{key}"), key.to_s]
    end
  end

  def referral_source_options
    referral_sources.keys.map do |key|
      [I18n.t("activerecord.attributes.enrollment.referral_sources.#{key}"), key.to_s]
    end
  end
end
