class Admin::InstructorsController < ApplicationController
  before_action :set_instructor, except: [:index, :new, :create]

  layout 'admin/application'

  def index
    @instructors = Instructor.includes([:avatar_attachment])
                             .search(params[:term]).order(:name)
  end

  def show; end

  def new
    @instructor = Instructor.new
  end

  def edit; end

  def create
    @instructor = Instructor.new(instructor_params)

    if @instructor.save
      redirect_to admin_instructors_path,
                  notice: t('flash_messages.created', model: Instructor.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @instructor.update(instructor_params)
      redirect_to admin_instructors_path,
                  notice: t('flash_messages.updated', model: Instructor.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_avatar
    avatar_params = params.require(:instructor).permit(:avatar)

    if @instructor.update(avatar_params)
      redirect_to admin_instructor_path(@instructor.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete_avatar
    @instructor.avatar.purge
    redirect_to admin_instructor_path(@instructor.id), notice: t('flash_messages.avatar_deleted')
  end

  def destroy
    @instructor.destroy

    redirect_to admin_instructors_path,
                notice: t('flash_messages.destroyed', model: Instructor.model_name.human)
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(:name, :email, :phone, :active, :resume)
  end
end
