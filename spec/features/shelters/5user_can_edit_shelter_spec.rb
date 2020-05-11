require 'rails_helper'

RSpec.describe "Shleters edit page", type: :feature do
  before :each do
    @shelter1 = Shelter.create(
      name: "the lab",
      address: "123 Dog Street",
      city: "Dog Town",
      state: "DO",
      zip: "12345"
    )

  end
  it "can edit a shelter's info" do

    visit "/shelters/#{@shelter1.id}/edit"

    fill_in "name", with: "Barks and Crafts"
    fill_in "address", with: "123 Ruff St"
    fill_in "city", with: "Dog town"
    fill_in "state", with: "DG"
    fill_in "zip", with: "99999"
    click_on "Update Shelter"

    expect(current_path).to eq("/shelters/#{@shelter1.id}")

    expect(page).to have_content("Name: Barks and Crafts")
    expect(page).to have_content("Address: 123 Ruff St")
    expect(page).to have_content("City: Dog town")
    expect(page).to have_content("State: DG")
    expect(page).to have_content("Zip: 99999")
  end

  it "can go to edit page from index" do

    visit "/shelters"

    expect(page).to have_link(href: "/shelters/#{@shelter1.id}/edit")

  end
  it "can go to edit page from show" do


    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter1.id}/edit")

  end
end
