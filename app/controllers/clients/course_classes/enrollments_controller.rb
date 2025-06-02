class Clients::CourseClasses::EnrollmentsController < Clients::BaseController
  before_action :set_course_class, except: :index
  before_action :prevent_duplicate_enrollment, only: :new

  def index
    @enrollments = current_client.enrollments
                                 .includes([:payments, { course_class: [course: [:image_attachment]] }])
                                 .order(created_at: :desc)
                                 .search(params[:term])
                                 .page(params[:page])
  end

  def new
    @enrollment = current_client.enrollments.new
  end

  def create
    @enrollment = current_client.enrollments.new(
      enrollment_params.merge(course_class_id: @course_class.id)
    )

    if @enrollment.save
      redirect_to clients_new_payment_path(@course_class, @enrollment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:course_class_id])
  end

  def prevent_duplicate_enrollment
    return unless current_client.enrolled_in?(@course_class)

    redirect_to clients_enrollments_path, notice: t('errors.messages.already_enrolled')
  end

  def enrollment_params
    params.expect(enrollment: [:referral_source, :category,
                               :notes, :terms_accepted, :previous_participation])
  end
end
