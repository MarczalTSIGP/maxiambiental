module Populators
  class BasePopulate
    include Singleton

    def self.populate(amount = 30)
      instance.delete
      amount.times { instance.create }
      instance.log(amount)
    end

    def create; end

    def delete
      model.destroy_all
    end

    def log(amount = '')
      Rails.logger.info "Delete #{model_name.pluralize.downcase} and populate with #{amount} registers"
    end

    private

    def model
      class_name = self.class.to_s.demodulize.gsub('Populate', '')
      class_name.classify.constantize
    end

    def model_name
      model.to_s
    end
  end
end
