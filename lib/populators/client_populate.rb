module Populators
  class ClientPopulate < Populators::BasePopulate
    def create
      FactoryBot.create(:client)
    end
  end
end
