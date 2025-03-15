class HomeController < ApplicationController
  layout 'layouts/home/application'

  def index
    @courses = Course.includes(image_attachment: :blob).order(:name)
  end
end
