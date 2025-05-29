class Clients::EnrollmentsController < ApplicationController
  layout 'layouts/clients/application'

  before_action :set_course_class, except: :index

  def index
    @enrollments = current_client.enrollments
                                 .includes(:course_class)
                                 .order(created_at: :desc)
                                 .search(params[:term])
                                 .page(params[:page])
  end

  # step 1 - client information
  def edit_client; end

  def update_client
    if current_client.update(client_params)
      redirect_to clients_new_enrollment_path
    else
      render :edit_client, status: :unprocessable_entity
    end
  end

  def new
    @enrollment = @course_class.enrollments.new
  end

  def create
    @enrollment = @course_class.enrollments.new(enrollment_params)

    if @enrollment.save
      redirect_to clients_enrollment_payments_path(@enrollment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def payment
    @enrollment = @course_class.enrollments.find(params[:id])
    @payment = Payment.new
  end

  def update_payment
    @enrollment = @course_class.enrollments.find(params[:id])

    if @enrollment.update(status: Enrollment.statuses[:confirmed])
      redirect_to clients_enrollment_confirmation_path
    else
      render :payment, status: :unprocessable_entity
    end
  end

  def confirmation
    @enrollment = @course_class.enrollments.find(params[:id])

    if @enrollment.confirmed?
      render :confirmation
    else
      redirect_to clients_update_enrollment_payments_path(@enrollment)
    end
  end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:course_class_id])
  end

  def client_params
    params.expect(client: [:name, :cpf, :email, :phone, :cep, :city, :state, :address, :formation, :current_company])
  end

  def enrollment_params
    params.expect(enrollment: [:client_id, :course_class_id, :referral_source, :previous_participation, :category,
                               :notes, :terms_accepted])
  end
end
