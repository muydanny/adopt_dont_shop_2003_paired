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

  it "can remove pet from favorites" do

    visit '/pets'

    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end

    find('.favorite_indicator').click
    expect(current_path).to eq("/favorites")
    expect(page).to have_css("img[src*='https://i.redd.it/4ygdq7e6gze11.jpg']")

    within("#delete-#{@pet1.id}") do
      click_button "Remove #{@pet1.name} from favorites"
    end

    expect(current_path).to eq("/favorites")

    expect(page).not_to have_css("img[src*='https://i.redd.it/4ygdq7e6gze11.jpg']")

  end

  it "can remove pet from pet index" do

    visit '/pets'

    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end

    within("#delete-#{@pet1.id}") do
      click_button "Remove #{@pet1.name} from favorites"
    end

    expect(current_path).to eq("/pets")

  end

  it "can remove pet from pet show" do

    visit "/pets/#{@pet1.id}"

    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end

    within("#delete-#{@pet1.id}") do
      click_button "Remove #{@pet1.name} from favorites"
    end

    expect(current_path).to eq("/pets/#{@pet1.id}")

  end



end
