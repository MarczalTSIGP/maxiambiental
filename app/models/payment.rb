class Payment < ApplicationRecord
  attr_accessor :card_number,
                :card_holder_name,
                :card_cvv,
                :card_expiry_date,
                :card_holder_document,
                :payment_method

  enum :status, {
    pending: 'pending',
    confirmed: 'confirmed',
    canceled: 'canceled'
  }

  belongs_to :enrollment
  belongs_to :client

  validates :payment_method, presence: true

  after_create_commit :confirm_payment

  def human_status
    I18n.t("activerecord.attributes.payment.statuses.#{status}")
  end

  def human_statuses
    statuses.map do |key, _value|
      [I18n.t("activerecord.attributes.payment.statuses.#{key}"), key]
    end
  end

  private

  def confirm_payment
    update(status: :confirmed)
    enrollment.update(status: :confirmed)
  end
end
