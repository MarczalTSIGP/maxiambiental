class UploadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    blob = ActiveStorage::Blob.create_and_upload!(io: params[:file], filename: params[:file].original_filename)
    render json: { url: url_for(blob) }
  end

  def destroy
    # Extraia o ID do Active Storage a partir do URL fornecido
    blob_id = extract_blob_id(params[:url])

    if blob_id
      blob = ActiveStorage::Blob.find_by(key: blob_id)

      if blob.present?
        blob.purge # Remove o arquivo do storage
        render json: { message: "Imagem deletada com sucesso" }, status: :ok
      else
        render json: { error: "Arquivo não encontrado" }, status: :not_found
      end
    else
      render json: { error: "URL inválido" }, status: :unprocessable_entity
    end
  end

  private

  def extract_blob_id(url)
    matched = url.match(%r{/rails/active_storage/blobs/.+?/(.+)$})
    matched ? matched[1] : nil
  end
end
