class BaseForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Translation

  def self.human_attribute_name(attribute, _options = {})
    model_name.to_s.constantize.human_attribute_name(attribute)
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, model_name_name)
  end

  def self.model_name_name
    name.demodulize.sub(/Form$/, '')
  end
end
