class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/

  def validate_each(record, attribute, value)
    return if value.present? && value.match?(EMAIL_REGEX)

    record.errors.add(attribute, message: options[:message] || I18n.t('errors.messages.email'))
  end
end
