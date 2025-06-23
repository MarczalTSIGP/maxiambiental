class Clients::BaseController < ApplicationController
  layout 'layouts/clients/application'

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  private

  def handle_record_not_found
    redirect_to not_found_path
  end
end
