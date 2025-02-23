class CoursesController < ApplicationController
  def index
    @courses = Course.includes(image_attachment: :blob)
  end
end
