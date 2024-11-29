# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Admin.create_with(password: '123456', name: 'Maxiambiental').find_or_create_by!(email: 'admin@maxiambiental.com')


# institutional = InstitutionalContent.create!(
#   title: 'Nossa História',
#   content: ActionText::RichText.create!(
#     body: <<-HTML
#       <h2>Sobre Nossa Instituição</h2>
#       <p>Fundada em 2010, nossa instituição tem como missão...</p>
#       <p>Nosso compromisso é com a excelência e inovação.</p>
#     HTML
#   )
# )

# # Anexe a imagem dos assets
# image_path = Rails.root.join('app', 'assets', 'images', 'default_institutional.png')

# if File.exist?(image_path)
#   institutional.image.attach(
#     io: File.open(image_path),
#     filename: 'default_institutional.png',
#     content_type: 'image/jpeg'
#   )
# else
#   puts "Imagem não encontrada em #{image_path}"
# end