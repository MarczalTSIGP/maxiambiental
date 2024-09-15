Rails.application.routes.draw do
  root 'home#index'
  
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_for :admins, controllers: { sessions: 'admin/devise/sessions' }

  authenticate :admin do
    namespace :admin do
      root 'dashboard#index'
      get 'profile' => 'profiles#index', as: :profile
      resource :profile, only: [:edit, :update] do
        delete :avatar, on: :collection, as: :delete_avatar
      end
    end
  end

  devise_for :clients, controllers: { 
    sessions: 'clients/devise/sessions',
    registrations: 'clients/devise/registrations'}

  authenticate :client do
    namespace :clients do
      root 'home#index'
      get 'profile' => 'profiles#index', as: :profile
      resource :profile, only: [:edit, :update] do
        delete :avatar, on: :collection, as: :delete_avatar
      end
    end
  end
end
