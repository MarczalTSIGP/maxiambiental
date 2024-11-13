class InstitutionalContent < ApplicationRecord
  has_one_attached :img

  has_rich_text :content
end
