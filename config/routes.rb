Rails.application.routes.draw do
  root 'home#index'

  match '404', via: :all, to: 'errors#not_found'
  match '500', via: :all, to: 'errors#internal_server_error'

  get 'up' => 'rails/health#show', as: :rails_health_check

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

      resources :instructors
    end
  end

  devise_for :clients,
             controllers: {
               registrations: 'clients/devise/registrations',
               sessions: 'clients/devise/sessions',
               passwords: 'clients/devise/passwords',
               unlocks: 'clients/devise/unlocks',
               omniauth_callbacks: 'clients/devise/omniauth_callbacks',
               confirmations: 'clients/devise/confirmations'
             }

  authenticate :client do
    namespace :clients do
      get 'profile', to: 'profile#index', as: :profile
      get 'profile/edit', to: 'profile#edit', as: :edit_profile
      get 'profile/edit/password', to: 'profile#edit_password', as: :edit_password

      patch 'profile/update', to: 'profile#update', as: :update_profile
      patch 'profile/update_avatar', to: 'profile#update_avatar', as: :update_avatar
      patch 'profile/update_password', to: 'profile#update_password', as: :update_password

      delete 'profile/delete_avatar', to: 'profile#delete_avatar', as: :delete_avatar
    end
  end
end
