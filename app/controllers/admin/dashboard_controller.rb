class Admin::DashboardController < Admin::BaseController
  before_action :initialize_admin_dashboard

  def index
    load_dashboard_data
  end

  private

  def initialize_admin_dashboard
    @dashboard = Dashboard::Admin.new
  end

  def load_dashboard_data
    @clients   = @dashboard.top_clients
    @courses   = @dashboard.top_courses
  end
end
