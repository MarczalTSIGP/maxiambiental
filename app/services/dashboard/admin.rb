class Dashboard::Admin
  def last_30_days
    {
      count: last_30_days_count,
      growth: customer_percentage_increase
    }
  end

  def top_clients
    Client.includes([:avatar_attachment]).order(created_at: :desc).limit(5)
  end

  def top_courses
    Course.includes([:image_attachment]).order(created_at: :desc).limit(5)
  end

  private

  def last_30_days_count
    Client.where(created_at: 30.days.ago..).count
  end

  def previous_30_days_count
    Client.where(created_at: 60.days.ago..).where(created_at: ...30.days.ago).count
  end

  def customer_percentage_increase
    return 0 if previous_30_days_count.zero?

    increase = last_30_days_count - previous_30_days_count
    ((increase.to_f / previous_30_days_count) * 100).round(1)
  end
end
