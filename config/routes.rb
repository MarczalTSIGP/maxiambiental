Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  match '404', via: :all, to: 'errors#not_found'
  match '500', via: :all, to: 'errors#internal_server_error'

  # Defines the root path route ("/")
  root 'home#index'

  devise_for :admins, controllers: { sessions: 'admin/devise/sessions', passwords: 'admin/devise/passwords' }

  authenticate :admin do
    namespace :admin do
      root 'dashboard#index'

      get 'profile/edit', to: 'profile#edit', as: :edit_profile
      get 'profile/edit/password', to: 'profile#edit_password', as: :edit_password

      patch 'profile/update', to: 'profile#update', as: :update_profile
      patch 'profile/update_avatar', to: 'profile#update_avatar', as: :update_avatar
      patch 'profile/update_password', to: 'profile#update_password', as: :update_password

      delete 'profile/delete_avatar', to: 'profile#delete_avatar', as: :delete_avatar
    end
  end
end
