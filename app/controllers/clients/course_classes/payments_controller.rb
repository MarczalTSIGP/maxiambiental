class Clients::CourseClasses::PaymentsController < Clients::BaseController
  before_action :set_enrollment
  before_action :set_course_class
  before_action :set_payment, only: :confirmation
  before_action :validate_enrollment_status, only: :new
  before_action :validate_payment_status, only: :confirmation

  def new
    @payment = Payment.new
  end

  def create
    @payment = @enrollment.payments.new(client: current_client, **payment_params)

    if @payment.save
      redirect_to clients_payment_confirmation_path(@payment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation; end

  private

  def set_payment
    @payment = Payment.find(params[:payment_id])
  end

  def set_enrollment
    @enrollment = Enrollment.find(params[:enrollment_id])
  end

  def set_course_class
    @course_class = @enrollment.course_class
  end

  def payment_params
    params.expect(payment: [:payment_method])
  end

  def validate_enrollment_status
    redirect_to clients_course_classes_enrollments_path if @enrollment.confirmed?
  end

  def validate_payment_status
    return if @enrollment.confirmed?

    redirect_to clients_new_course_class_enrollment_payment_path(@course_class, @enrollment)
  end
end
