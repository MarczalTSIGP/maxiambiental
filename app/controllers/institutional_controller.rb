class InstitutionalController < ApplicationController
  before_action :set_institutional_content

  def index; end

  private

  def set_institutional_content
    @institutional = InstitutionalContent.first_or_initialize
  end
end
