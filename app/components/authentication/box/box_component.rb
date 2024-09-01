# frozen_string_literal: true

class Authentication::Box::BoxComponent < ViewComponent::Base
    def initialize(head_title:)
        @head_title = head_title
    end
end
