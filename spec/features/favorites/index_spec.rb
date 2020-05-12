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

    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
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

    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end
    within("#fav-#{@pet2.id}") do
      click_button "Add #{@pet2.name} to favorites"
    end
    find('.favorite_indicator').click

    expect(current_path).to eq("/favorites")

    within("#delete-#{@pet1.id}") do
      click_button "Remove #{@pet1.name} from favorites"
    end

    expect(current_path).to eq("/favorites")

    expect(page).not_to have_css("img[src*='https://i.redd.it/4ygdq7e6gze11.jpg']")

    within("##{@pet2.name}") do
      expect(page).to have_content(@pet2.name)
    end
    expect(page).to have_css("img[src*='https://image.shutterstock.com/image-photo/cute-american-shorthair-cat-kitten-260nw-352176329.jpg']")

  end

  it "shows remove from favorites if pet has been added to favorites" do
    visit '/pets'

    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end

    within("#delete-#{@pet1.id}") do
      click_button "Remove #{@pet1.name} from favorites"
    end

  end

  it "shows prompt when there are no favorite pets" do
    visit '/favorites'

    expect(page).to have_content("You have no favorited pets")

    visit '/pets'
    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end

    visit '/favorites'

    expect(page).not_to have_content("You have no favorited pets")
    expect(page).to have_content("#{@pet1.name}")

  end

  it "can remove all favorites with button on favorites index" do
    visit '/pets'
    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end
    expect(page).to have_css(".favorite_indicator", text: 1)

    within("#fav-#{@pet2.id}") do
      click_button "Add #{@pet2.name} to favorites"
    end
    expect(page).to have_css(".favorite_indicator", text: 2)

    find('.favorite_indicator').click
    expect(current_path).to eq("/favorites")

    within("##{@pet1.id}-info") do
      expect(page).to have_content(@pet1.name)
    end
    within("##{@pet2.id}-info") do
      expect(page).to have_content(@pet2.name)
    end

    within("#remove-all-from-fav") do
      click_button "Remove all pets from favorites"
    end

    expect(page).to have_content("You have no favorited pets")
    expect(page).to have_css(".favorite_indicator", text: 0)


  end



end
