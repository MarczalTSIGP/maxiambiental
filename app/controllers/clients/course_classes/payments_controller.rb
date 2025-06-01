class Clients::CourseClasses::PaymentsController < Clients::BaseController
  before_action :set_course_class
  before_action :set_enrollment
  before_action :validate_enrollment_status, only: :new
  before_action :validate_payment_status, only: :confirmation

  def new
    @payment = Payment.new
  end

  def create
    @payment = current_client.payments.new(enrollment: @enrollment, **payment_params)

    if @payment.save
      redirect_to clients_payment_confirmation_path(payment_id: @payment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation; end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:course_class_id])
  end

  def set_enrollment
    @enrollment = @course_class.enrollments.find(params[:enrollment_id])
  end

  def payment_params
    params.expect(payment: [:payment_method])
  end

  def validate_enrollment_status
    redirect_to clients_enrollments_path unless @enrollment.payment_pending?
  end

  def validate_payment_status
    redirect_to new_clients_payment_path(@enrollment) unless @enrollment.payment.confirmed?
  end
end
