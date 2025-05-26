class Client < ApplicationRecord
  include Searchable

  has_many :enrollments, dependent: :destroy
  has_many :course_classes, through: :enrollments

  searchable :email, name: { unaccent: true }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :timeoutable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: true }

  validates :name, presence: true

  has_one_attached :avatar

  def self.from_google(user)
    client = create_with(
      uid: user[:uid],
      provider: 'google',
      password: Devise.friendly_token[0, 20],
      name: user[:name]
    ).find_or_create_by!(email: user[:email])

    client.skip_confirmation! if client.respond_to?(:skip_confirmation!)
    client
  end

  def avatar_url
    return ActionController::Base.helpers.asset_path('default-avatar.png') unless avatar.attached?

    Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
  end

  def google_authenticated?
    uid.present?
  end

  def set_random_password
    return if password.present?

    self.password = Devise.friendly_token[0, 20]
    self.password_confirmation = password
  end
end
