class Admin::EnrollmentsController < Admin::BaseController
  def index
    @enrollments = Enrollment.includes([:course_class, :client])
                             .order(created_at: :desc)
                             .search(params[:term])
                             .page(params[:page])
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end
end
