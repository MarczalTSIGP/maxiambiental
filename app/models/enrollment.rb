class Enrollment < ApplicationRecord
  include Searchable

  enum :category, { teacher: 'teacher', student: 'student' }

  enum :status, {
    pending: 'pending',
    confirmed: 'confirmed',
    finished: 'finalized',
    canceled: 'canceled'
  }

  enum :referral_source, {
    social_media: 'social_media',
    friends: 'friends',
    website: 'website',
    email: 'email',
    others: 'others'
  }

  searchable :status, relationships: {
    course_class: { fields: ['name'], unaccent: true },
    client: { fields: ['name'], unaccent: true }
  }

  belongs_to :client
  belongs_to :course_class
  has_many :payments, dependent: :destroy

  validates :category, presence: true
  validates :referral_source, presence: true
  validates :terms_accepted, acceptance: true
  validates :client_id, uniqueness: { scope: :course_class_id }

  validate :course_class_must_be_open, on: :create

  def payment
    payments.last
  end

  def human_enum(enum_name)
    I18n.t("activerecord.attributes.enrollment.#{enum_name.to_s.pluralize}.#{self[enum_name]}")
  end

  def human_enums(enum_name)
    self.class.public_send(enum_name.to_s.pluralize).map do |key, _|
      [I18n.t("activerecord.attributes.enrollment.#{enum_name.to_s.pluralize}.#{key}"), key]
    end
  end

  private

  def course_class_must_be_open
    return if course_class&.open?

    errors.add(:course_class,
               I18n.t('errors.messages.must_be_in_progress', attribute: CourseClass.model_name.human))
  end
end
