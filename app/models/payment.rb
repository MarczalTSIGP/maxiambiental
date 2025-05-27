class Payment < ApplicationRecord
  attr_accessor :card_number, :card_holder_name, :card_cvv, :card_expiry_date, :card_holder_document, :payment_method

  belongs_to :client

  validates :card_number, :card_holder_name, :card_cvv, :card_expiry_date, :card_holder_document, presence: true
  validates :amount, presence: true
  validates :payment_method, presence: true
end
