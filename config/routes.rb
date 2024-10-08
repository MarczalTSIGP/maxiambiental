Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'

  devise_for :admins, controllers: { sessions: 'admin/devise/sessions', passwords: 'admin/devise/passwords' }

  authenticate :admin do
    namespace :admin do
      root 'dashboard#index'

      get 'profile', to: 'profile#index', as: :profile
      get 'profile/edit', to: 'profile#edit', as: :edit_profile

      patch 'profile/update', to: 'profile#update', as: :update_profile
      patch 'profile/update_avatar', to: 'profile#update_avatar', as: :update_avatar

      delete 'profile/delete_avatar', to: 'profile#delete_avatar', as: :delete_avatar
    end
  end
end
