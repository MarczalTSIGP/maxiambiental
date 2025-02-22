class Admin::CoursesController < Admin::BaseController
  def new
    @course = Course.new
  end
end
