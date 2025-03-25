class HomeController < ApplicationController
  layout 'layouts/home/application'

  def index
    @courses = Course.includes(image_attachment: :blob).limit(6).order(:name)
  end
end
