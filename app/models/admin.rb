class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable,
         :rememberable, :validatable, :lockable, :timeoutable

  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: { case_sensitive: true }
  
  validates :name, presence: true

  has_one_attached :avatar
end
