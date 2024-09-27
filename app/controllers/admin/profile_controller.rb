class Admin::ProfileController < Admin::BaseController
  before_action :set_admin, only: [:edit, :update, :update_avatar, :delete_avatar]

  def edit; end

  def update
    if @admin.update_with_password(admin_params)
      bypass_sign_in(@admin)
      redirect_to admin_profile_path, notice: 'Perfil atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_avatar
    if @admin.update(admin_params)
      redirect_to edit_admin_profile_path, notice: 'Avatar atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete_avatar
    @admin.avatar.purge
    redirect_to edit_admin_profile_path, notice: 'Avatar removido com sucesso.'
  end

  private

  def set_admin
    @admin = current_admin
  end

  def admin_params
    params.require(:admin).permit(:name, :email, :avatar, :current_password, :password, :password_confirmation)
  end
end