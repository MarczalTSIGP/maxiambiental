class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  def index
    @courses = Course.includes([:rich_text_description, :image_attachment]).order(:name)
  end

  def show; end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
