class Admin::CoursesController < Admin::BaseController
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

  private

  def course_params
    params.require(:course).permit(:name, :description, :image)
  end
end
