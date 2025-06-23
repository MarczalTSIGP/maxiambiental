class HomeController < ApplicationController
  layout 'layouts/home/application'

  def index
    @course_classes = CourseClass.includes([course: :image_attachment]).open.limit(6).order(:start_at)
  end
end
