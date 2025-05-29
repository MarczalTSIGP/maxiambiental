class CpfValidator < ActiveModel::EachValidator
  CPF_LENGTH = 11

  def validate_each(record, attribute, value)
    return if value.blank?

    cpf = normalize(value)

    return if valid_cpf?(cpf)

    record.errors.add(attribute, :invalid_cpf, **options.slice(:message), value: value)
  end

  private

  def normalize(value)
    value.to_s.gsub(/\D/, '')
  end

  def valid_cpf?(cpf)
    return false unless cpf.match?(/\A\d{#{CPF_LENGTH}}\z/)
    return false if repeated_digits?(cpf)

    numbers = cpf.chars.map(&:to_i)
    valid_check_digits?(numbers)
  end

  def repeated_digits?(cpf)
    cpf =~ /^(\d)\1{#{CPF_LENGTH - 1}}$/
  end

  def valid_check_digits?(digits)
    digit9 = digits.take(9)
    digit10 = calculate_verifier_digit(digit9, 10)
    digit11 = calculate_verifier_digit(digit9 << digit10, 11)

    digits[9] == digit10 && digits[10] == digit11
  end

  def calculate_verifier_digit(partial_digits, weight)
    sum = partial_digits.each_with_index.sum do |digit, index|
      digit * (weight - index)
    end

    mod = sum % 11
    mod < 2 ? 0 : 11 - mod
  end
end
