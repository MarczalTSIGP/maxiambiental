class Dashboard::Admin
  def clients_metrics
    {
      count: last_30_days_count(Client),
      growth: percentage_increase(Client)
    }
  end

  def enrollments_metrics
    {
      count: last_30_days_count(Enrollment),
      growth: percentage_increase(Enrollment)
    }
  end

  def top_clients
    Client.includes([:avatar_attachment])
          .joins(:enrollments)
          .group(:id)
          .order('COUNT(enrollments.id) DESC')
          .limit(5)
  end

  def top_courses
    Course.includes([:image_attachment])
          .joins(course_classes: :enrollments)
          .group(:id)
          .order('COUNT(enrollments.id) DESC')
          .limit(5)
  end

  private

  def last_30_days_count(model)
    model.where(created_at: 30.days.ago..).count
  end

  def previous_30_days_count(model)
    model.where(created_at: 60.days.ago..30.days.ago).count
  end

  def percentage_increase(model)
    previous_count = previous_30_days_count(model)
    return 0 if previous_count.zero?

    increase = last_30_days_count(model) - previous_count
    ((increase.to_f / previous_count) * 100).round(1)
  end
end
