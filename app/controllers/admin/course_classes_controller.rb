class Admin::CourseClassesController < Admin::BaseController
  before_action :set_course_class, only: [:show, :edit, :update]

  def index
    @course_classes = CourseClass.includes([:course, :instructor])
                                 .order(:start_at)
                                 .search(params[:term])
                                 .page(params[:page])
  end

  def show; end

  def new
    @course_class = CourseClass.new
  end

  def edit; end

  def create
    @course_class = CourseClass.new(course_class_params)

    if @course_class.save
      redirect_to admin_course_classes_path,
                  notice: t('flash_messages.created', model: CourseClass.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @course_class.update(course_class_params)
      redirect_to admin_course_classes_path,
                  notice: t('flash_messages.updated', model: CourseClass.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:id])
  end

  def course_class_params
    params.expect(course_class: [
                    :name, :address, :schedule, :about, :programming, :subscription_status,
                    :available_slots, :acceptance_terms, :start_at, :end_at, :active,
                    :course_id, :instructor_id
                  ])
  end
end
