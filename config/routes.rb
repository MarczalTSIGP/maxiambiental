Rails.application.routes.draw do
  root 'home#index'

  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker

  get 'courses', to: 'courses#index', as: :courses
  get 'courses/:id', to: 'courses#show', as: :course

  get 'course_classes', to: 'course_classes#index', as: :course_classes
  get 'course_classes/:id', to: 'course_classes#show', as: :course_class
  get 'course_classes/:id/programming', to: 'course_classes#programming', as: :course_class_programming
  get 'course_classes/:id/instructor', to: 'course_classes#instructor', as: :course_class_instructor
  get 'course_classes/:id/terms', to: 'course_classes#terms', as: :course_class_terms

  match '404', via: :all, to: 'errors#not_found', as: :not_found
  match '500', via: :all, to: 'errors#internal_server_error', as: :internal_server_error

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
      patch 'instructors/:id/update_avatar', to: 'instructors#update_avatar', as: :update_instructor_avatar
      delete 'instructors/:id/delete_avatar', to: 'instructors#delete_avatar', as: :delete_instructor_avatar

      get 'instructors/search/(:term)/(page/:page)',
          constraints: { term: %r{[^/]+} },
          to: 'instructors#index',
          as: 'instructors_search'

      resources :courses, except: :show

      get 'courses/search/(:term)/(page/:page)',
          constraints: { term: %r{[^/]+} },
          to: 'courses#index',
          as: 'courses_search'

      resources :clients

      get 'clients/search/(:term)/(page/:page)',
          constraints: { term: %r{[^/]+} },
          to: 'clients#index',
          as: 'clients_search'

      resources :course_classes

      get 'course_classes/search/(:term)/(page/:page)',
          constraints: { term: %r{[^/]+} },
          to: 'course_classes#index',
          as: 'course_classes_search'
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

      get 'enrollments', to: 'course_classes/enrollments#index', as: :enrollments

      get 'enrollments/search/(:term)/(page/:page)',
          constraints: { term: %r{[^/]+} },
          to: 'course_classes/enrollments#index',
          as: 'course_classes_search'

      scope 'course_classes/:course_class_id' do
        get 'edit_client', to: 'course_classes/client#edit', as: :edit_client
        patch 'update_client', to: 'course_classes/client#update', as: :update_client

        get 'enrollments/new', to: 'course_classes/enrollments#new', as: :new_enrollment
        post 'enrollments', to: 'course_classes/enrollments#create', as: :create_enrollment

        scope 'enrollments/:enrollment_id' do
          get 'payments/new', to: 'course_classes/payments#new', as: :new_payment
          post 'payments', to: 'course_classes/payments#create', as: :create_payment

          get 'payments/confirmation', to: 'course_classes/payments#confirmation',
                                       as: :payment_confirmation
        end
      end
    end
  end
end
