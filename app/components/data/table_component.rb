# frozen_string_literal: true

class Data::TableComponent < ViewComponent::Base
  def initialize(attributes:, collection:, partial:)
    super()
    @attributes = attributes
    @collection = collection
    @partial = partial
  end

  private

  def model
    @collection.model.model_name.element
  end

  def table_id
    "#{model.pluralize}_table"
  end
end
