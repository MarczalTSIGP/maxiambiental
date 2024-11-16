class Admin::InstitutionalController < Admin::BaseController
  before_action :set_institutional_content
  
  def edit; end

  def update
    if @institutional_content.update(institutional_content_params)
      redirect_to admin_instituional_path, notice: 'Conteúdo atualizado com sucesso!'
    else
      render :edit, alert: 'Erro ao atualizar conteúdo.'
    end
  end

  private

  def set_institutional_content
    @institutional_content = InstitutionalContent.first_or_initialize
  end

  def institutional_content_params
    params.require(:institutional_content).permit(:title, :content)
  end
end
