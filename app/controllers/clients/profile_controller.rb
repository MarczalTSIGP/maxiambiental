class Clients::ProfileController < ApplicationController
  before_action :set_client

  layout 'layouts/clients/application'

  def edit; end

  def update
    update_method = @client.google_authenticated? ? :update : :update_with_password

    if @client.send(update_method, client_params)
      bypass_sign_in(@client)
      redirect_to clients_edit_profile_path, notice: t('flash_messages.profile_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_password; end

  def update_password
    client_pwd_params = params
                        .expect(client: [:current_password, :password, :password_confirmation])

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
    params.expect(client: [:name, :email, :bio, :avatar, :current_password])
  end
end
