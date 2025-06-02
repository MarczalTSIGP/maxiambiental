class Clients::CourseClasses::ClientController < Clients::BaseController
  before_action :set_course_class

  def edit; end

  def update
    if current_client.update(client_params)
      redirect_to clients_new_enrollment_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:course_class_id])
  end

  def client_params
    params.expect(client: [:name, :cpf, :phone, :formation,
                           :cep, :city, :state, :address, :current_company])
  end
end
