class CepValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    cep = value.gsub(/[^0-9]/, '')
    return unless cep.length != 8

    record.errors.add(attribute, :invalid)
  end
end
