class Instructor < ApplicationRecord
  include Searchable

  searchable :email, name: { unaccent: true }

  validates :email,
            presence: true,
            uniqueness: true,
            email: true

  validates :phone,
            presence: true,
            phone: true

  validates :name, presence: true, length: { minimum: 3 }

  validates :resume, presence: true

  has_one_attached :avatar
  has_rich_text :resume

  def avatar_url
    return ActionController::Base.helpers.asset_path('default-avatar.png') unless avatar.attached?

    Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
  end
end
