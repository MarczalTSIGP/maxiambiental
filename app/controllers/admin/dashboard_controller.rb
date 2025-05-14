class Admin::DashboardController < Admin::BaseController
  before_action :initialize_admin_dashboard

  def index
    load_dashboard_data
  end

  private

  def initialize_admin_dashboard
    @admin_dashboard = Dashboard::Admin.new
  end

  def load_dashboard_data
    @clients_metrics = @admin_dashboard.clients_metrics
    @clients   = @admin_dashboard.top_clients
    @courses   = @admin_dashboard.top_courses
  end
end
