class Admin::DashboardController < Admin::BaseController
  before_action :set_admin_dashboard

  def index
    @clients_stats = @admin_dashboard.last_30_days
    @clients = @admin_dashboard.top_clients
    @courses = @admin_dashboard.top_courses
  end

  private

  def set_admin_dashboard
    @admin_dashboard = Dashboard::Admin.new
  end
end
