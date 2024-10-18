class Admin::ProfileController < Admin::BaseController
  before_action :set_admin

  def edit; end

  def update
    if @admin.update_with_password(admin_params)
      bypass_sign_in(@admin)
      redirect_to admin_edit_profile_path, notice: t('flash_messages.profile_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_password; end

  def update_password
    admin_pwd_params = params.require(:admin)
                             .permit(:current_password, :password, :password_confirmation)

    if @admin.update_with_password(admin_pwd_params)
      bypass_sign_in(@admin)
      redirect_to admin_edit_password_path, notice: t('flash_messages.password_updated')
    else
      render :edit_password, status: :unprocessable_entity
    end
  end

  def update_avatar
    if @admin.update(admin_params)
      redirect_to admin_edit_profile_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete_avatar
    @admin.avatar.purge
    redirect_to admin_edit_profile_path, notice: t('flash_messages.avatar_deleted')
  end

  private

  def set_admin
    @admin = current_admin
  end

  def admin_params
    params.require(:admin).permit(:name, :email, :avatar, :current_password)
  end
end
