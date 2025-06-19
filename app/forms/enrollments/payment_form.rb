class Enrollments::PaymentForm < BaseForm
  attr_accessor :payment_method, :card_number, :card_holder_name,
                :card_cvv, :card_expiry_date, :card_holder_document

  validates :payment_method, presence: true

  def create(enrollment)
    enrollment.payments.create!(attributes.merge(client: enrollment.client))
  end

  def attributes
    {
      payment_method: payment_method
    }
  end

  def params
    [:payment_method]
  end

  def human_payment_methods
    payment_methods.map do |key|
      [I18n.t("activerecord.attributes.payment.methods.#{key}"), key]
    end
  end

  def payment_methods
    %w[bank_slip creditCard debitCard pix]
  end
end
