class Admin::InstructorsController < ApplicationController
  layout 'admin/application'

  def index
    @instructors = Instructor.all
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_params)

    if @instructor.save
      redirect_to admin_instructors_path, notice: 'Instructor was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def instructor_params
    params.require(:instructor).permit(:name, :email, :phone, :resume)
  end
end
