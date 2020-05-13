require 'rails_helper'

RSpec.describe "Shleters can be deleted ", type: :feature do
  before :each do
    @shelter1 = Shelter.create(
      name: "figaro figaro figaro",
      address: "123 the shop",
      city: "disney",
      state: "DI",
      zip: "33333"
    )
  end

  it "can delete a shelter from index" do
    visit "/shelters"
    expect(page).to have_content("figaro figaro figaro")
    click_button "Delete #{@shelter1.name}"
    expect(current_path).to eq("/shelters")
    expect(page).not_to have_content("figaro figaro figaro")
  end

  it "can delete a shelter from show" do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content("Name: #{@shelter1.name}")
    expect(page).to have_content("Address: #{@shelter1.address}")
    expect(page).to have_content("City: #{@shelter1.city}")
    expect(page).to have_content("State: #{@shelter1.state}")
    expect(page).to have_content("Zip: #{@shelter1.zip}")

    click_button "Delete #{@shelter1.name}"

    expect(current_path).to eq("/shelters")

    expect(page).not_to have_content("Name: #{@shelter1.name}")
    expect(page).not_to have_content("Address: #{@shelter1.address}")
    expect(page).not_to have_content("City: #{@shelter1.city}")
    expect(page).not_to have_content("State: #{@shelter1.state}")
    expect(page).not_to have_content("Zip: #{@shelter1.zip}")
  end

end
