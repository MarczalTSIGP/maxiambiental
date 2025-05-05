class Admin::ClientsController < Admin::BaseController
  def index
    @clients = Client.includes([:avatar_attachment])
                     .search(params[:term])
                     .order(:name)
                     .page(params[:page])
  end
end
