class Enrollment < ApplicationRecord
  enum :category, { teacher: 'teacher', student: 'student' }

  enum :status, { pending: 'pending',
                  confirmed: 'confirmed',
                  finished: 'finalized',
                  canceled: 'canceled' }

  enum :referral_source, { social_media: 'social_media',
                           friends: 'friends',
                           website: 'website',
                           email: 'email',
                           others: 'others' }

  include Searchable

  searchable :course_class

  belongs_to :client
  belongs_to :course_class

  has_many :payments, dependent: :destroy

  validates :category, presence: true, inclusion: { in: categories }
  validates :terms_accepted, acceptance: true
  validates :referral_source, presence: true, inclusion: { in: referral_sources }
  validates :client_id, uniqueness: { scope: :course_class_id }

  def human_enum(enum_name)
    I18n.t("activerecord.attributes.enrollment.#{enum_name.to_s.pluralize}.#{self[enum_name]}")
  end

  def human_enums(enum_name)
    self.class.defined_enums[enum_name.to_s].map do |key, _|
      [I18n.t("activerecord.attributes.enrollment.#{enum_name.to_s.pluralize}.#{key}"), key]
    end
  end

  def payment_pending?
    payments.empty? || payment.pending?
  end

  def payment
    payments.last
  end
end
