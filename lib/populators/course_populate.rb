module Populators
  class CoursePopulate < Populators::BasePopulate
    def create
      FactoryBot.create(:course)
    end
  end
end
