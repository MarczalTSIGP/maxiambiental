class Admin::ProfileController < Admin::BaseController
  before_action :set_admin, only: [:edit, :update]

  def edit; end

  def update
    if @admin.update(admin_params)
      redirect_to admin_profile_path, notice: 'Perfil atualizado com sucesso.'
    else
      render :edit
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
    params.require(:admin).permit(:name, :email, :avatar)
  end
end