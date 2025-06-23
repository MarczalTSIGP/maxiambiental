class Enrollments::CourseEnrollmentForm
  include ActiveModel::Model

  STEPS = [:client, :enrollment, :payment, :confirmation].freeze

  attr_reader :current_step
  attr_accessor :client, :course_class, :enrollment_draft

  def initialize(course_class:, client: nil, attributes: {})
    @client = client
    @course_class = course_class
    @attributes = attributes
    @enrollment_draft = find_or_create_draft
    @current_step = (@enrollment_draft.current_step || :client).to_sym
  end

  def completed? = current_step == :confirmation
  def final_step? = current_step == :payment

  def move_to_next_step
    return if completed?

    @current_step = STEPS[STEPS.index(current_step) + 1]
    save_draft
  end

  def move_to_previous_step
    return if current_step == STEPS.first

    @current_step = STEPS[STEPS.index(current_step) - 1]
    save_draft
  end

  delegate :valid?, to: :current_form

  def update(attributes)
    @attributes = { current_step => attributes }
    current_form.assign_attributes(attributes)
    valid?
  end

  def save
    return false unless all_steps_valid?

    persist_data
    destroy_draft
    true
  rescue StandardError => e
    Rails.logger.info "Error saving data: #{e.message}"
    errors.add(:base, "Error saving data: #{e.message}")
    false
  end

  def current_form
    @current_form ||= build_form(current_step, @attributes)
  end

  def form_index = STEPS.index(current_step) + 1

  private

  def build_form(step, attributes)
    return if step == :confirmation

    data = attributes[step] || @enrollment_draft.send("#{step}_data") || {}

    case step
    when :client then Enrollments::ClientForm.new(@client, data)
    when :enrollment then Enrollments::EnrollmentForm.new(data)
    when :payment then Enrollments::PaymentForm.new(data)
    else raise "Invalid step: #{step}"
    end
  end

  def all_steps_valid?
    STEPS.none? { |step| step != :confirmation && !build_form(step, {}).valid? }
  end

  def save_draft
    @enrollment_draft.update(
      current_step: current_step,
      **forms_attributes
    )
  end

  def forms_attributes
    STEPS.each_with_object({}) do |step, hash|
      next if step == :confirmation

      form = build_form(step, @attributes)
      hash["#{step}_data"] = form.attributes if form
    end
  end

  def find_or_create_draft
    EnrollmentDraft.find_or_initialize_by(client: @client, course_class: @course_class)
  end

  def destroy_draft
    @enrollment_draft.destroy if @enrollment_draft.persisted?
  end

  def persist_data
    ActiveRecord::Base.transaction do
      build_form(:client, {}).update
      enrollment = build_form(:enrollment, {}).create(client, course_class)
      build_form(:payment, {}).create(enrollment)
    end
  end
end
