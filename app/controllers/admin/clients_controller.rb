class Admin::ClientsController < Admin::BaseController
  before_action :set_client, only: [:destroy]

  def index
    @clients = Client.includes([:avatar_attachment])
                     .search(params[:term])
                     .order(:name)
                     .page(params[:page])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.set_random_password

    if @client.save
      send_account_creation_email(@client)
      redirect_to admin_clients_path,
                  notice: t('flash_messages.created', model: Client.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy

    redirect_to admin_clients_path,
                notice: t('flash_messages.destroyed', model: Client.model_name.human)
  end

  private

  def client_params
    params.expect(client: [:name, :email])
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
