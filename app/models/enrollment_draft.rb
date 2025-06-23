class EnrollmentDraft < ApplicationRecord
  belongs_to :client
  belongs_to :course_class

  validates :client_id, uniqueness: { scope: :course_class_id }

  # Garante retorno de hash vazio se os dados forem nulos
  def client_data
    self[:client_data] || {}
  end

  def enrollment_data
    self[:enrollment_data] || {}
  end

  def payment_data
    self[:payment_data] || {}
  end
end
