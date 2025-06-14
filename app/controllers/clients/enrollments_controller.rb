class Clients::EnrollmentsController < ApplicationController
  before_action :set_course_class
  before_action :validate_enrollment, only: [:new, :create]
  before_action :load_form, only: [:new, :create]

  def new; end

  def create
    if @form.update(form_params)
      handle_form_success
    else
      render :new, status: :unprocessable_entity
    end
  end

  def previous
    @form = load_form_from_session
    @form.move_to_previous_step
    save_form_to_session
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

  def load_form
    @form = load_form_from_session
  end

  def load_form_from_session
    session_data = (session[:enrollment_form] || {}).with_indifferent_access

    Enrollments::CourseEnrollmentForm.new(
      client: current_client,
      course_class: @course_class,
      attributes: session_data
    )
  end

  def form_params
    params.expect(@form.current_step => @form.current_form.params)
  end

  def handle_form_success
    @form.move_to_next_step
    save_form_to_session

    if @form.completed?
      finalize_enrollment
    else
      redirect_to clients_new_enrollment_path
    end
  end

  def save_form_to_session
    session[:enrollment_form] = @form.session_attributes
  end

  def finalize_enrollment
    if @form.save
      session.delete(:enrollment_form)
      redirect_to clients_enrollments_confirmation_path,
                  notice: t('flash_messages.created', model: Enrollment.model_name.human)
    else
      redirect_to clients_previous_enrollment_path,
                  notice: t('errors.messages.enrollment_failed')
    end
  end
end
