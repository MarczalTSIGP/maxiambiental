Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'

  devise_for :admins, controllers: { sessions: 'admin/devise/sessions' }

  authenticate :admin do
    namespace :admin do
      root 'dashboard#index'
      resource :profile, only: [:edit, :update] do
        delete :avatar, on: :collection, as: :delete_avatar
      end
    end
  end
end
