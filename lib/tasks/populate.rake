Rails.root.glob('lib/populators/*.rb').each { |file| require file }

namespace :db do
  desc 'Erase and fill database'
  task populate: :environment do
    include Populators
    ActiveStorage.logger = Logger.new($stdout)
    ActiveStorage.logger.level = Logger::WARN

    puts 'Running populate'

    ClientPopulate.populate(30)
    InstructorPopulate.populate(20)
    CoursesPopulate.populate(9)
    CourseClassesPopulate.populate(6)

    Rake::Task['db:seed'].invoke
  end
end
