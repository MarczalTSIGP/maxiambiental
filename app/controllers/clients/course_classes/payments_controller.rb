class Clients::CourseClasses::PaymentsController < Clients::BaseController
  before_action :set_enrollment
  before_action :validate_enrollment_status

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to clients_payments_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation; end

  private

  def set_enrollment
    @enrollment = Enrollment.find(params[:enrollment_id])
  end

  def payment_params
    params.expect(payment: [:amount, :enrollment_id, :client_id])
  end

  def validate_enrollment_status
    redirect_to clients_course_classes_enrollments_path if @enrollment.confirmed?
  end
end
