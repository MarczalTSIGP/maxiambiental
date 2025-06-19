class Enrollments::CourseEnrollmentForm
  include ActiveModel::Model

  STEPS = [:client, :enrollment, :payment, :confirmation].freeze

  attr_reader :current_step
  attr_accessor :client, :course_class

  def initialize(course_class:, client: nil, attributes: {})
    @current_step = (attributes[:current_step] || :client).to_sym
    @client = client
    @course_class = course_class
    initialize_forms(attributes)
  end

  def completed? = current_step == :confirmation
  def final_step? = current_step == :payment

  def move_to_next_step
    @current_step = next_step unless completed?
  end

  def move_to_previous_step
    @current_step = previous_step unless first_step?
  end

  def current_form
    @current_form ||= send("#{current_step}_form")
  end

  def form_index
    STEPS.index(current_step) + 1
  end

  delegate :valid?, to: :current_form

  def update(attributes)
    current_form.assign_attributes(attributes)
    valid?
  end

  def save
    return false unless all_steps_valid?

    persist_data
    true
  rescue StandardError => e
    errors.add(:base, "Error saving data: #{e.message}")
    false
  end

  def session_attributes
    {
      current_step: current_step,
      client_data: client_form.attributes,
      enrollment_data: enrollment_form.attributes,
      payment_data: payment_form.attributes
    }
  end

  private

  attr_reader :client_form, :enrollment_form, :payment_form

  def initialize_forms(attributes)
    @client_form = Enrollments::ClientForm.new(@client, attributes[:client_data] || {})
    @enrollment_form = Enrollments::EnrollmentForm.new(attributes[:enrollment_data] || {})
    @payment_form = Enrollments::PaymentForm.new(attributes[:payment_data] || {})
  end

  def next_step = STEPS[STEPS.index(current_step) + 1]
  def previous_step = STEPS[STEPS.index(current_step) - 1]
  def first_step? = current_step == STEPS.first

  def all_steps_valid?
    [client_form, enrollment_form, payment_form].all? | form | form.valid?
  end

  def persist_data
    ActiveRecord::Base.transaction do
      client_form.update
      enrollment = enrollment_form.create(client, course_class)
      payment_form.create(enrollment)
    end
  end
end
