class CourseClass < ApplicationRecord
  include Searchable

  searchable(
    { name: { unaccent: true } },
    {
      relationships: {
        instructor: { fields: ['name'] },
        course: { fields: ['name'] }
      }
    }
  )

  belongs_to :course
  belongs_to :instructor

  validates :name, :start_at, :end_at, :schedule, :address, :about, :programming, :payments_info, presence: true

  validates :end_at, comparison: { greater_than: :start_at }

  has_rich_text :about
  has_rich_text :programming
  has_rich_text :payments_info
end
