class Admin < ApplicationRecord
  devise :database_authenticatable, :recoverable, :trackable,
         :rememberable, :validatable, :lockable, :timeoutable

  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: { case_sensitive: true }
end
