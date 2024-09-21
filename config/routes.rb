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
      resources :profile, only: [:index, :edit, :update]
    end
  end
end
