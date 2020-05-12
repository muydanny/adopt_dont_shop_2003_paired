require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "validates values" do
    # it {should have_many :pets}
  end

  it "can calculate the total number of pets in favorites" do
    favorite = Favorite.new({
      1 => 1,
      2 => 1
      })

    expect(favorite.total_count).to eq(2)
  end
end
