# frozen_string_literal: true

class Admin::Header::HeaderComponent < ViewComponent::Base
    def initialize(current_admin:)
        super
        @current_admin = current_admin
    end
end
