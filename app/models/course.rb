class Course < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true

  has_one_attached :image
  has_rich_text :description

  def image_url
    return ActionController::Base.helpers.asset_path('card-default.png') unless image.attached?

    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
  end
end
