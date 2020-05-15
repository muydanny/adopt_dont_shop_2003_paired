require 'rails_helper'

RSpec.describe "Shleters create page", type: :feature do
  it "can create a shelter" do

    visit "/shelters"

    expect(page).not_to have_content("Barks and Crafts")

    visit "/shelters/new"

    fill_in "name", with: "Barks and Crafts"
    fill_in "address", with: "123 Ruff St"
    fill_in "city", with: "Dog town"
    fill_in "state", with: "DG"
    fill_in "zip", with: "99999"
    click_on "Create Shelter"

    last_shelter = Shelter.last
    expect(page).to have_content("Barks and Crafts")
    expect(page).to have_content("You have created #{last_shelter.name}")

    click_link "Barks and Crafts"


    expect(current_path).to eq("/shelters/#{last_shelter.id}")

    expect(page).to have_content("Name: Barks and Crafts")
    expect(page).to have_content("Address: 123 Ruff St")
    expect(page).to have_content("City: Dog town")
    expect(page).to have_content("State: DG")
    expect(page).to have_content("Zip: 99999")


  end

  it "displays notice when fields are not filled in" do
    visit "/shelters/new"

    fill_in "name", with: "Barks and Crafts"
    fill_in "address", with: "123 Ruff St"

    click_on "Create Shelter"


    expect(current_path).to eq("/shelters/new")
    expect(page).to have_content("You must fill out all fields")


  end
end
