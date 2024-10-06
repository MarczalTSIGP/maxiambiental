Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  
  root 'home#index'

  devise_for :admins, controllers: { sessions: 'admin/devise/sessions', passwords: 'admin/devise/passwords' }

  authenticate :admin do
    namespace :admin do
      root 'dashboard#index'
    end
  end

  devise_for :clients, controllers: 
  {
    sessions: 'clients/devise/sessions', 
    registrations: 'clients/devise/registrations',
    passwords: 'clients/devise/passwords',
    confirmations: 'clients/devise/confirmations',
    omniauth_callbacks: 'clients/devise/omniauth_callbacks'
  }

  authenticate :client do
    namespace :clients do
      resources :profile, only: [:index, :edit, :update]
    end
  end
end
