class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.present? && value.match?(/\A\(?\d{2}\)?\s?\d{4,5}-?\d{4}\z/)

    record.errors.add(attribute, :invalid_phone, message: I18n.t('errors.messages.phone'))
  end
end
