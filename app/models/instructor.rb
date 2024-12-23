class Instructor < ApplicationRecord
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/ }

  validates :phone,
            presence: true,
            format: { with: /\A\(?\d{2}\)?\s?\d{4,5}-?\d{4}\z/ }

  validates :name, presence: true, length: { minimum: 3 }

  has_one_attached :avatar
  has_rich_text :resume
end
