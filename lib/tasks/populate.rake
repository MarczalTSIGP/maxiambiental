Rails.root.glob('lib/populators/*.rb').each { |file| require file }

namespace :db do
  desc 'Erase and fill database'
  task populate: :environment do
    include Populators
    ActiveStorage.logger = Logger.new($stdout)
    ActiveStorage.logger.level = Logger::WARN

    puts 'Running populate'

    Populators::ClientPopulate.populate(30)
    Populators::InstructorPopulate.populate(20)
    Populators::CoursePopulate.populate(9)
    Populators::CourseClassPopulate.populate(6)

    Rake::Task['db:seed'].invoke
  end
end
