class Course < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 20 }

  has_one_attached :image

  def image_url
    return ActionController::Base.helpers.asset_path('default-avatar.png') unless image.attached?

    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
  end
end
