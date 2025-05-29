class Clients::EnrollmentsController < Clients::BaseController
  before_action :set_course_class, except: :index
  before_action :prevent_duplicate_enrollment, only: :new

  def index
    @enrollments = current_client.enrollments
                                 .includes(course_class: [course: [:image_attachment]])
                                 .order(created_at: :desc)
                                 .search(params[:term])
                                 .page(params[:page])
  end

  def new
    @enrollment = @course_class.enrollments.new
  end

  def create
    @enrollment = current_client.enrollments.new(
      enrollment_params.merge(course_class_id: @course_class.id)
    )

    if @enrollment.save
      redirect_to clients_enrollment_payments_path(@enrollment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_client; end

  def update_client
    if current_client.update(client_params)
      redirect_to clients_new_enrollment_path
    else
      render :edit_client, status: :unprocessable_entity
    end
  end

  private

  def set_course_class
    @course_class = CourseClass.find(params[:course_class_id])
  end

  def prevent_duplicate_enrollment
    redirect_to clients_enrollments_path if current_client.enrolled_in?(@course_class)
  end

  def client_params
    params.expect(client: [
                    :name, :cpf, :phone, :formation,
                    :cep, :city, :state, :address, :current_company
                  ])
  end

  def enrollment_params
    params.expect(enrollment: [
                    :referral_source, :category,
                    :notes, :terms_accepted, :previous_participation
                  ])
  end
end
