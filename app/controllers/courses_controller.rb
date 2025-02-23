class CoursesController < ApplicationController
  def index
    @courses = Course.includes(image_attachment: :blob).order(:name)
  end
end
