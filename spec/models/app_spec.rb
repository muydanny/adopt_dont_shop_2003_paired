require 'rails_helper'

RSpec.describe App, type: :model do

  describe "relationships" do

  it {should have_many :pet_apps}
  it {should have_many(:pets).through(:pet_apps)}

  end
end
