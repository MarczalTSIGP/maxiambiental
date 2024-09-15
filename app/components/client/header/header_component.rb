# frozen_string_literal: true

class Client::Header::HeaderComponent < ViewComponent::Base
  def initialize(navigation_links: nil)
    super
    @navigation_links = navigation_links
  end
end
