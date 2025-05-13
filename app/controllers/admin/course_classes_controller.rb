class Admin::CourseClassesController < Admin::BaseController
  def new
    @course_class = CourseClass.new
  end
end
