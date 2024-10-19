class Client < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :timeoutable, :omniauthable, omniauth_providers: [:google_oauth2]
  
  def self.from_google(u)
    client = create_with(uid: u[:uid], provider: 'google',
                         password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])

    client.skip_confirmation! if client.respond_to?(:skip_confirmation!)

    client
  end 
end