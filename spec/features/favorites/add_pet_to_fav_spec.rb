require 'rails_helper'

RSpec.describe "When a user adds a pet to their favorites" do
  before :each do
    @shelter1 = Shelter.create(
      name: "the lab",
      address: "666 dog Ave",
      city: "ruff town",
      state: "DG",
      zip: "12345"
    )
    @pet1 = Pet.create(
      name: "Dr. Dog",
      age: "4",
      sex: "male",
      description: "well educated",
      image: "https://i.redd.it/4ygdq7e6gze11.jpg",
      shelter_id: @shelter1.id,
      adoptable: true
    )
    @pet2 = Pet.create(
      name: "Oreo",
      age: "55",
      sex: "female",
      description: "best if dipped in milk",
      image: "https://image.shutterstock.com/image-photo/cute-american-shorthair-cat-kitten-260nw-352176329.jpg",
      shelter_id: @shelter1.id,
      adoptable: false
    )
  end

  it "displays a message" do
    visit "/pets"

    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end

    expect(page).to have_content("You have added #{@pet1.name} to your favorites")
  end

  it "displays the total number of favorite pets" do

    visit "/pets"


    expect(page).to have_css(".favorite_indicator", text: 0)

    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end


    expect(page).to have_css(".favorite_indicator", text: 1)

    within("#fav-#{@pet2.id}") do
      click_button "Add #{@pet2.name} to favorites"
    end

    expect(page).to have_css(".favorite_indicator", text: 2)

  end

  it "can only add 1 pet" do
    visit "/pets"


    expect(page).to have_css(".favorite_indicator", text: 0)

    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end

    expect(page).to have_css(".favorite_indicator", text: 1)


end


end
