class Clients::EnrollmentsController < Clients::BaseController
  before_action :set_course_class, except: [:index]
  before_action :validate_class, only: [:new, :create, :previous]
  before_action :validate_enrollment, only: [:new, :create, :previous]
  before_action :load_form, only: [:new, :create, :previous]

  def index
    @enrollments = current_client.enrollments
                                 .includes([:payments, { course_class: [course: [:image_attachment]] }])
                                 .order(created_at: :desc)
                                 .search(params[:term])
                                 .page(params[:page])
  end

  def new; end

  def create
    if @form.update(form_params)
      handle_form_success
    else
      render :new, status: :unprocessable_entity
    end
  end

  def previous
    @form.move_to_previous_step
    redirect_to clients_new_enrollment_path
  end

  def confirmation; end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:course_class_id])
  end

  def validate_enrollment
    return unless current_client.enrolled_in?(@course_class)

    redirect_to clients_enrollments_path,
                notice: t('errors.messages.already_enrolled')
  end

  def validate_class
    return if @course_class.open?

    redirect_to clients_enrollments_path,
                notice: t('errors.messages.must_be_open', attribute: Enrollment.model_name.human)
  end

  def load_form
    @form = Enrollments::CourseEnrollmentForm.new(
      client: current_client,
      course_class: @course_class
    )
  end

  def form_params
    params.expect(@form.current_step => @form.current_form.params)
  end

  def handle_form_success
    @form.move_to_next_step

    if @form.completed?
      finalize_enrollment
    else
      redirect_to clients_new_enrollment_path
    end
  end

  def finalize_enrollment
    if @form.save
      redirect_to clients_enrollments_confirmation_path(@course_class),
                  notice: t('flash_messages.created', model: Enrollment.model_name.human)
    else
      redirect_to clients_previous_enrollment_path,
                  notice: t('errors.messages.enrollment_failed')
    end
  end
end
