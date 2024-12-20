class Admin::InstructorsController < ApplicationController
  before_action :set_instructor, only: [:show, :edit, :update]

  layout 'admin/application'

  def index
    @instructors = Instructor.all
  end
  
  def show; end

  def new
    @instructor = Instructor.new
  end

  def edit; end

  def create
    @instructor = Instructor.new(instructor_params)

    if @instructor.save
      redirect_to admin_instructors_path,
                  notice: t('flash_messages.created', model: Instructor.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:removed_images].present?
      JSON.parse(params[:removed_images]).each do |image_url|
        blob_key = extract_blob_key(image_url)
        Rails.logger.info "--------------------#{blob_key}"
        blob = ActiveStorage::Blob.find_by(id: blob_key)

        blob.purge # Remove do Active Storage e da integração com o Cloudflare
      end
    end

    if @instructor.update(instructor_params)
      redirect_to admin_instructors_path,
                  notice: t('flash_messages.updated', model: Instructor.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(:name, :email, :phone, :active, :resume)
  end

  def extract_blob_key(url)
    return nil unless url.present?

    # Tenta extrair o ID codificado da URL de redirecionamento
    if url.include?('/redirect/')
      encoded_data = url.match(/\/redirect\/([^\/]+)/)&.[](1)
      return nil unless encoded_data

      begin
        # Decodifica o payload Base64 e extrai o blob_id
        decoded = Base64.strict_decode64(encoded_data.split('--').first)
        data = JSON.parse(decoded)
        return data['_rails']['data']
      rescue StandardError => e
        Rails.logger.error "Error decoding blob ID: #{e.message}"
        return nil
      end
    end
  end
end
