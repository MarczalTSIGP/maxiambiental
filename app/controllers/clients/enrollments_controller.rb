class Clients::EnrollmentsController < ApplicationController
  layout 'layouts/clients/application'

  before_action :set_course_class

  def edit_client
    @client = current_client
  end

  def update_client
    @client = current_client

    if @client.update(client_params)
      redirect_to root_path,
                  notice: t('flash_messages.updated', model: Client.model_name.human)
    else
      render :client, status: :unprocessable_entity
    end
  end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:course_class_id])
  end

  def client_params
    params.expect(client: [:name, :email, :phone, :cep, :city, :state, :address, :formation, :current_company])
  end
end
