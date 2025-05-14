class Admin::ClientsController < Admin::BaseController
  before_action :set_client, only: [:edit, :update, :destroy]

  def index
    @clients = Client.includes([:avatar_attachment])
                     .search(params[:term])
                     .order(:name)
                     .page(params[:page])
  end

  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params)
    @client.set_random_password

    if @client.save
      redirect_to admin_clients_path,
                  notice: t('flash_messages.created', model: Client.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      redirect_to admin_clients_path,
                  notice: t('flash_messages.updated', model: Client.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy

    redirect_to admin_clients_path,
                notice: t('flash_messages.destroyed', model: Client.model_name.human)
  end

  private

  def client_params
    params.expect(client: [:name, :email, :active])
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
