FactoryBot.define do
  factory :enrollment_draft do
    current_step { :client }
    client
    course_class

    trait :enrollment_step do
      current_step { :enrollment }
      client_data { client.attributes.slice(:name, :email, :cpf, :phone, :cep, :address, :city, :state) }
    end

    trait :payment_step do
      current_step { :payment }
      client_data { client.attributes.slice(:name, :email, :cpf, :phone, :cep, :address, :city, :state) }
      enrollment_data { attributes_for(:enrollment).slice(:category, :referral_source, :terms_accepted) }
    end

    trait :confirmation_step do
      current_step { :confirmation }
      client_data { client.attributes.slice(:name, :email, :cpf, :phone, :cep, :address, :city, :state) }
      enrollment_data { attributes_for(:enrollment).slice(:category, :referral_source, :terms_accepted) }
      payment_data { { payment_method: 'credit_card' } }
    end
  end
end
