class Admin::CourseClassesController < Admin::BaseController
  def new
    @course_class = CourseClass.new
  end

  def create
    @course_class = CourseClass.new(course_class_params)

    if @course_class.save
      redirect_to admin_course_classes_path,
                  notice: t('flash_messages.created', model: CourseClass.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def course_class_params
    params.expect(course_class: [:name, :address, :city, :period, :about, :programming, :start_at, :end_at, :course_id,
                                 :instructor_id])
  end
end
