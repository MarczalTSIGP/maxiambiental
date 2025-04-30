require_relative 'base_populate'

class CoursesPopulate < Populators::BasePopulate
  def create
    FactoryBot.create(:course)
  end
end
