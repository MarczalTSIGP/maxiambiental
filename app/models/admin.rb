class Admin < ApplicationRecord
  devise :database_authenticatable, :recoverable, :trackable,
         :rememberable, :validatable, :lockable, :timeoutable

  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: { case_sensitive: true }
  
  validates :name, presence: true

  has_one_attached :avatar

  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
    else
      '/images/default-avatar.png'
    end
  end
end
