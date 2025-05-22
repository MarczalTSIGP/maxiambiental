class CourseClassesController < ApplicationController
  before_action :set_course_class, except: [:index]

  def index
    @course_classes = CourseClass.includes([:course]).order(:start_at)
  end

  def show; end

  def programming; end

  def instructor; end

  def terms; end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:id])
  end
end
