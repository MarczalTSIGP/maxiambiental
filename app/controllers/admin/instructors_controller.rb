class Admin::InstructorsController < ApplicationController
  layout 'admin/application'
  def new
    @instructor = Instructor.new
  end
end
