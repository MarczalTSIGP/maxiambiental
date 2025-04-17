require_relative 'base_populate'

class InstructorPopulate < Populators::BasePopulate
  def create
    FactoryBot.create(:instructor)
  end
end
