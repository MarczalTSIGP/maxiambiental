class Admin::ClientsController < Admin::BaseController
  before_action :set_client, only: [:destroy]

  def index
    @clients = Client.includes([:avatar_attachment])
                     .search(params[:term])
                     .order(:name)
                     .page(params[:page])
  end

  def destroy
    @client.destroy

    redirect_to admin_clients_path,
                notice: t('flash_messages.destroyed', model: Client.model_name.human)
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end
end
