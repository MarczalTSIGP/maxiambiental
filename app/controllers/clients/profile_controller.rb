class Clients::ProfileController < ApplicationController
  before_action :set_client

  layout 'layouts/clients/application'

  def edit; end

  def update
    if @client.update_with_password(client_params)
      bypass_sign_in(@client)
      redirect_to clients_edit_profile_path, notice: t('flash_messages.profile_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def basic_update
    client_basic_params = params.require(:client).permit(:name, :bio)

    if @client.update(client_basic_params)
      bypass_sign_in(@client)
      redirect_to clients_edit_profile_path, notice: t('flash_messages.profile_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_password; end

  def update_password
    client_pwd_params = params.require(:client)
                              .permit(:current_password, :password, :password_confirmation)

    if @client.update_with_password(client_pwd_params)
      bypass_sign_in(@client)
      redirect_to clients_edit_password_path, notice: t('flash_messages.password_updated')
    else
      render :edit_password, status: :unprocessable_entity
    end
  end

  def update_avatar
    if @client.update(client_params)
      redirect_to clients_edit_profile_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete_avatar
    @client.avatar.purge
    redirect_to clients_edit_profile_path, notice: t('flash_messages.avatar_deleted')
  end

  private

  def set_client
    @client = current_client
  end

  def client_params
    params.require(:client).permit(:name, :email, :bio, :avatar, :current_password)
  end
end
