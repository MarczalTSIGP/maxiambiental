class Admin::CoursesController < Admin::BaseController
  before_action :set_course, only: [:edit, :update]

  def index
    @courses = Course.includes(:image_attachment)
  end

  def new
    @course = Course.new
  end

  def edit; end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to admin_courses_path,
                  notice: t('flash_messages.created', model: Course.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      redirect_to admin_courses_path,
                  notice: t('flash_messages.updated', model: Course.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :image)
  end
end
