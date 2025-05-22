class CourseClassesController < ApplicationController
  def index
    @course_classes = CourseClass.includes([:course]).order(:start_at)
  end
end
