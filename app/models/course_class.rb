class CourseClass < ApplicationRecord
  belongs_to :course
  belongs_to :instructor

  validates :name, :start_at, :end_at, :period, :address, :city, presence: true

  validates :end_at, comparison: { greater_than: :start_at }

  has_rich_text :about
  has_rich_text :programming
end
