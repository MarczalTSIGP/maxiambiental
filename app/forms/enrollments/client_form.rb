class Enrollments::ClientForm < BaseForm
  attr_accessor :name, :email, :cpf, :phone, :address, :city, :state, :cep

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :email, presence: true, email: true
  validates :cpf, presence: true, cpf: true
  validates :phone, presence: true, phone: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :cep, presence: true, cep: true

  def initialize(client, attributes = {})
    @client = client

    attributes = default_attributes.merge(attributes)
    super(attributes)
  end

  def update
    @client.update(client_attributes)
  end

  def attributes
    {
      name: name,
      email: email,
      cpf: cpf,
      phone: phone,
      address: address,
      city: city,
      state: state,
      cep: cep
    }
  end

  def params
    [:name, :cpf, :phone, :address, :city, :state, :cep]
  end

  private

  def default_attributes
    {
      name: @client.name,
      email: @client.email,
      cpf: @client.cpf,
      phone: @client.phone,
      address: @client.address,
      city: @client.city,
      state: @client.state,
      cep: @client.cep
    }
  end

  def client_attributes
    attributes.symbolize_keys
  end
end
