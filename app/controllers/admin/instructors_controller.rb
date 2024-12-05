class Admin::InstructorsController < ApplicationController
  before_action :set_instructor, only: [:edit, :update]

  layout 'admin/application'

  def index
    @instructors = Instructor.all
  end

  def new
    @instructor = Instructor.new
  end

  def edit; end

  def create
    @instructor = Instructor.new(instructor_params)

    if @instructor.save
      redirect_to admin_instructors_path, notice: 'Instructor was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @instructor.update(instructor_params)
      redirect_to admin_instructors_path, notice: 'Instructor was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(:name, :email, :phone, :resume)
  end
end
