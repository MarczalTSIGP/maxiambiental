# frozen_string_literal: true

class AvatarDropdown::AvatarDropdownComponent < ViewComponent::Base
  def initialize(user:)
    super
    @user = user
  end
end
