class Dashboard::Admin
  def clients_metrics
    {
      count: clients_last_30_days_count,
      growth: clients_percentage_increase
    }
  end

  def top_clients
    Client.includes([:avatar_attachment]).order(created_at: :desc).limit(5)
  end

  def top_courses
    Course.includes([:image_attachment]).order(created_at: :desc).limit(5)
  end

  private

  def clients_last_30_days_count
    Client.where(created_at: 30.days.ago..).count
  end

  def clients_previous_30_days_count
    Client.where(created_at: 60.days.ago..30.days.ago).count
  end

  def clients_percentage_increase
    previous_count = clients_previous_30_days_count
    return 0 if previous_count.zero?

    increase = clients_last_30_days_count - previous_count
    ((increase.to_f / previous_count) * 100).round(1)
  end
end
