class Admin::ProfileController < Admin::BaseController
  before_action :set_admin, only: [:edit, :update, :update_avatar]

  def edit; end

  def update
    if @admin.update_with_password(admin_params)
      bypass_sign_in(@admin)
      redirect_to admin_edit_profile_path, notice: t('flash_messages.profile_updated')
    else
      # @admin_for_update_pwd.errors.clear if admin_params.key?(:password)

      render :edit, status: :unprocessable_entity
    end
  end

  def update_avatar
    if @admin.update(admin_params)
      redirect_to admin_edit_profile_path, notice: t('flash_messages.avatar_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete_avatar
    current_admin.avatar.purge
    redirect_to admin_edit_profile_path, notice: t('flash_messages.avatar_deleted')
  end

  private

  def set_admin
    @admin = current_admin.dup
    @admin_for_update_pwd = current_admin.dup
  end

  def admin_params
    params.require(:admin).permit(:name, :email, :avatar, :current_password, :password, :password_confirmation)
  end
end
