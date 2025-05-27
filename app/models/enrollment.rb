class Enrollment < ApplicationRecord
  enum :category, { teacher: 'teacher', student: 'student' }
  enum :status, { pending: 'pending', confirmed: 'confirmed', canceled: 'canceled' }

  include Searchable

  searchable :course_class

  belongs_to :client
  belongs_to :course_class

  validates :client_id, uniqueness: { scope: :course_class_id, message: I18n.t('errors.messages.already_enrolled') }
  validates :category, inclusion: { in: categories }
  validates :terms_accepted, acceptance: true
end
