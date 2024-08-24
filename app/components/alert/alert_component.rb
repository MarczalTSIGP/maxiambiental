# frozen_string_literal: true

class Alert::AlertComponent < ViewComponent::Base  
    def initialize(type:, message:)
      @type = type.to_sym
      @message = message
    end
  
    def background_class
      Alert::Types::STYLES[@type][:background]
    end
  
    def border_class
      Alert::Types::STYLES[@type][:border]
    end
  
    def text_class
      Alert::Types::STYLES[@type][:text]
    end
  end
  