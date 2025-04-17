Dir[Rails.root.join('lib/populators/*.rb')].each { |file| require file }

namespace :db do
  desc 'Erase and fill database'
  task populate: :environment do
    include Populators
    Rails.logger = Logger.new($stdout)

    puts 'Running seeds'

    ClientPopulate.populate(10)

    Rake::Task['db:seed'].invoke
  end
end
