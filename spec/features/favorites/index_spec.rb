require 'rails_helper'

RSpec.describe "Favorite Indicator", type: :feature do

  it "When I click on favorite indicator I am taken to favorite index" do
    visit '/pets'
    find('.favorite_indicator').click
    expect(current_path).to eq("/favorites")
  end
end
