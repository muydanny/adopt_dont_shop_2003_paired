require 'rails_helper'

RSpec.describe "Favorite Indicator", type: :feature do

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

  it "When I click on favorite indicator I am taken to favorite index" do
    visit '/pets'
    find('.favorite_indicator').click
    expect(current_path).to eq("/favorites")
  end

  it "can add pets to favorites (no duplicates) and then view on index" do
    visit '/pets'

    within("#pet-#{@pet1.id}") do
      click_button "Add Pet to Favorites"
    end

    within("#pet-#{@pet1.id}") do
      click_button "Add Pet to Favorites"
    end

    find('.favorite_indicator').click
    expect(current_path).to eq("/favorites")

    expect(page).to have_content(@pet1.name)
    expect(page).to have_css("img[src*='https://i.redd.it/4ygdq7e6gze11.jpg']")

    expect(page).not_to have_content(@pet2.name)
    expect(page).not_to have_css("img[src*='https://image.shutterstock.com/image-photo/cute-american-shorthair-cat-kitten-260nw-352176329.jpg']")
  end

  it "can delete a pet from favorites" do
    visit '/pets'
    visit '/pets'

    within("#pet-#{@pet1.id}") do
      click_button "Add Pet to Favorites"
    end

    within("#pet-#{@pet2.id}") do
      click_button "Add Pet to Favorites"
    end
    
  end


end
