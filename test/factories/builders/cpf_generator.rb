module CpfGenerator
  module_function

  def generate(formatted: true)
    cpf_base = generate_base_digits
    cpf_with_dv = append_verification_digits(cpf_base)
    formatted ? format_cpf(cpf_with_dv) : cpf_with_dv.join
  end

  def generate_base_digits
    Array.new(9) { rand(0..9) }
  end

  def append_verification_digits(base_digits)
    first_digit = calculate_verification_digit(base_digits, 10)
    partial_cpf = base_digits + [first_digit]

    second_digit = calculate_verification_digit(partial_cpf, 11)
    partial_cpf + [second_digit]
  end

  def calculate_verification_digit(digits, initial_weight)
    sum = digits.each_with_index.sum { |digit, i| digit * (initial_weight - i) }
    remainder = sum % 11
    remainder < 2 ? 0 : 11 - remainder
  end

  def format_cpf(digits)
    "#{digits[0..2].join}.#{digits[3..5].join}.#{digits[6..8].join}-#{digits[9..10].join}"
  end
end
