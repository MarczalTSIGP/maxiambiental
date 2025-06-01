class Clients::CourseClasses::PaymentsController < Clients::BaseController
  before_action :set_enrollment
  before_action :set_course_class
  before_action :validate_enrollment_status

  def new
    @payment = Payment.new
  end

  def create
    @payment = @enrollment.payments.new(client: current_client, **payment_params)

    if @payment.save
      redirect_to clients_course_class_enrollment_confirmation_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation; end

  private

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
end
