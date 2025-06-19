FactoryBot.define do
  factory :enrollment_draft do
    current_step { :client }

    client { nil }
    enrollment { nil }
    payment { nil }

    trait :enrollment_step do
      current_step { :enrollment }
      client do
        FactoryBot.create(:client)
                  .attributes.slice(:name, :cpf, :phone, :address, :city, :state, :cep)
      end
    end
  end
end
