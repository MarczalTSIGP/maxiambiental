require_relative 'base_populate'

class ClientPopulate < Populators::BasePopulate
  def create
    FactoryBot.create(:client)
  end
end
