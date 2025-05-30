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

  validates :category, inclusion: { in: categories }
  validates :terms_accepted, acceptance: true
  validates :referral_source, inclusion: { in: referral_sources }
  validates :client_id, uniqueness: { scope: :course_class_id }

  def human_enum(enum_name)
    enum_value = send(enum_name)
    return unless enum_value

    I18n.t("activerecord.attributes.enrollment.#{enum_name.to_s.pluralize}.#{enum_value}")
  end

  def human_enums(enum_name)
    send(enum_name.to_s.pluralize).map do |key, _value|
      [human_enum(enum_name.to_s.singularize + "_#{key}"), key]
    end
  end
end
