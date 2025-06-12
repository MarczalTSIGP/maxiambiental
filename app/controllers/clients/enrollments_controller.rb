class Clients::EnrollmentsController < ApplicationController
  before_action :set_course_class
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
    redirect_to enrollment_path
  end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:course_class_id])
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
    case @form.current_step
    when :client
      params.expect(client: [:name, :email, :cpf, :phone, :address, :city, :state, :cep])
    when :enrollment
      params.expect(enrollment: [:referral_source, :category, :notes, :terms_accepted, :previous_participation])
    when :payment
      params.expect(payment: [:payment_method])
    end
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
      redirect_to clients_enrollments_path, notice: 'Matrícula realizada com sucesso!'
    else
      render :new
    end
  end
end
