class Clients::EnrollmentsController < ApplicationController
  layout 'layouts/clients/application'

  before_action :set_course_class

  def new
    @enrollment = @course_class.enrollments.new
  end

  def create
    @enrollment = @course_class.enrollments.new(enrollment_params)

    if @enrollment.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_client
    @client = current_client
  end

  def update_client
    @client = current_client

    if @client.update(client_params)
      redirect_to clients_new_enrollment_path
    else
      render :edit_client, status: :unprocessable_entity
    end
  end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:course_class_id])
  end

  def client_params
    params.expect(client: [:name, :email, :phone, :cep, :city, :state, :address, :formation, :current_company])
  end

  def enrollment_params
    params.expect(enrollment: [:client_id, :course_class_id, :referral_source, :previous_participation, :category,
                               :notes, :terms_accepted])
  end
end
