class CourseClass < ApplicationRecord
  enum :subscription_status, {
    coming_soon: 0,
    open: 1,
    in_progress: 2,
    closed: 3,
    waiting_list: 4
  }

  include Searchable

  belongs_to :course
  belongs_to :instructor

  has_rich_text :about
  has_rich_text :address
  has_rich_text :programming
  has_rich_text :acceptance_terms

  validates :name, :start_at, :end_at, :schedule, :address,
            :about, :programming, :acceptance_terms,
            presence: true

  validates :end_at,
            comparison: { greater_than: :start_at }

  validates :available_slots, presence: true,
                              numericality: { greater_than: 0, only_integer: true }

  searchable(
    { name: { unaccent: true } },
    {
      relationships: {
        instructor: { fields: ['name'] },
        course: { fields: ['name'] }
      }
    }
  )

  def human_subscription_status
    I18n.t("activerecord.attributes.course_class.subscription_statuses.#{subscription_status}")
  end

  def self.human_subscription_statuses
    subscription_statuses.map do |key, _value|
      [I18n.t("activerecord.attributes.course_class.subscription_statuses.#{key}"), key]
    end
  end
end
