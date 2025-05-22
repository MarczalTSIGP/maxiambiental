class CourseClass < ApplicationRecord
  enum :subscription_status, { coming_soon: 0, open: 1, closed: 2, waiting: 3 }

  include Searchable

  belongs_to :course
  belongs_to :instructor

  has_rich_text :about
  has_rich_text :address
  has_rich_text :programming
  has_rich_text :payments_info

  validates :name, :start_at, :end_at, :schedule, :location,
            :about, :programming, :payments_info,
            presence: true

  validates :end_at,
            comparison: { greater_than: :start_at }

  searchable(
    { name: { unaccent: true } },
    {
      relationships: {
        instructor: { fields: ['name'] },
        course: { fields: ['name'] }
      }
    }
  )
end
