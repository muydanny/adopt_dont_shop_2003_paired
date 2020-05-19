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

  it "has a section listing pets with atleast 1 application, pet names are links" do

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

    within(".new-application") do
      click_button "New application for favorite pets"
    end
    expect(current_path).to eq("/apps/new")
    # both pets added to favorites
    select("#{@pet1.name}")
    fill_in :name, with: "Roger"
    fill_in :address, with: "101 Dalmation Plantation"
    fill_in :city, with: "London"
    fill_in :state, with: "UK"
    fill_in :zip, with: "10101"
    fill_in :phone_number, with: "101-101-1010"
    fill_in :description, with: "I'm a dog lover"

    click_button "Submit my application"
    #app for pet 1 complete, redirect_to "/favorites"
    @app = App.last

    expect(@app.pets).to eq([@pet1])
    expect(@pet1.apps).to eq([@app])
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Your application for the selected pets has been submitted")
    expect(page).not_to have_css("##{@pet1.id}-info")
    within("##{@pet2.id}-info")do
      expect(page).to have_content("#{@pet2.name}")
    end
    #pet 1 has been remvoed from favorites, while pet 2 is still in favorites

    within("#pets-apps")do
      expect(page).to have_content("#{@pet1.name}")
      expect(page).to have_link("#{@pet1.name}")
      click_link("#{@pet1.name}")
    end
    expect(current_path).to eq("/pets/#{@pet1.id}")

  end

  it "section of favorites with approved pets" do
    shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")
    shelter2 = Shelter.create(name: "S2", address: "A2",city: "C2",state: "ST",zip: "12345")

    pet1 = shelter1.pets.create(name: "P1",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet11 = shelter1.pets.create(name: "P11",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet111 = shelter1.pets.create(name: "P111",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet2 = shelter2.pets.create(name: "P2",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet22 = shelter2.pets.create(name: "P22",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)

    app1 = App.create(name:"A1X", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
    app11 = App.create(name:"A11", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
    app2 = App.create(name:"A2", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")

    PetApp.create(pet: pet1, app: app1, approved: true)
    PetApp.create(pet: pet1, app: app11, approved: false)
    PetApp.create(pet: pet11, app: app1, approved: true)
    PetApp.create(pet: pet111, app: app11, approved: false)
    PetApp.create(pet: pet2, app: app2, approved: true)
    PetApp.create(pet: pet22, app: app2, approved: false)

    visit '/favorites'

    within("#approved-pets")do
      expect(page).to have_link("#{pet1.name}")
      expect(page).to have_link("#{pet11.name}")
      expect(page).to_not have_link("#{pet111.name}")
      expect(page).to have_link("#{pet2.name}")
      expect(page).to_not have_link("#{pet22.name}")
    end

  end



end
