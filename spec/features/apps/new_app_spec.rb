require 'rails_helper'

RSpec.describe "New Application", type: :feature do

  before :each do
    @shelter1 = Shelter.create(name: "the lab", address: "666 dog Ave", city: "ruff town", state: "DG", zip: "12345")
    @pet1 = @shelter1.pets.create(name: "Dr. Dog", age: "4", sex: "male", description: "well educated", image: "https://i.redd.it/4ygdq7e6gze11.jpg", adoptable: true)
    @pet2 = @shelter1.pets.create(name: "Oreo", age: "55", sex: "female", description: "best if dipped in milk", image: "https://image.shutterstock.com/image-photo/cute-american-shorthair-cat-kitten-260nw-352176329.jpg", adoptable: false)
    @pet3 = @shelter1.pets.create(name: "Toad", age: "55", sex: "female", description: "best if dipped in milk", image: "https://image.shutterstock.com/image-photo/cute-american-shorthair-cat-kitten-260nw-352176329.jpg", adoptable: false)
    visit '/pets'
    within("#fav-#{@pet1.id}") do
      click_button "Add #{@pet1.name} to favorites"
    end
    expect(page).to have_css(".favorite_indicator", text: 1)

    within("#fav-#{@pet2.id}") do
      click_button "Add #{@pet2.name} to favorites"
    end
    expect(page).to have_css(".favorite_indicator", text: 2)

    within("#fav-#{@pet3.id}") do
      click_button "Add #{@pet3.name} to favorites"
    end
    expect(page).to have_css(".favorite_indicator", text: 3)

    find('.favorite_indicator').click
    expect(current_path).to eq("/favorites")

    within(".new-application") do
      click_button "Adopt my favorite pets"
    end
    expect(current_path).to eq("/apps/new")

  end
  it "can create a new appliaction form from favorite index"do

    select("#{@pet1.name}")
    select("#{@pet2.name}")
    fill_in :name, with: "Roger"
    fill_in :address, with: "101 Dalmation Plantation"
    fill_in :city, with: "London"
    fill_in :state, with: "UK"
    fill_in :zip, with: "10101"
    fill_in :phone_number, with: "101-101-1010"
    fill_in :description, with: "I'm a dog lover"

    click_button "Submit my application"

    @app = App.last

    expect(@app.pets).to eq([@pet1, @pet2])
    expect(@pet1.apps).to eq([@app])
    expect(@pet2.apps).to eq([@app])
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Your application for #{@pet1.name}, #{@pet2.name} has been submitted")
    expect(page).not_to have_css("##{@pet1.id}-info")
    expect(page).not_to have_css("##{@pet2.id}-info")
    expect(page).to have_css("##{@pet3.id}-info")

  end

  it "I have an incomplete application I am returned to same page with message" do

    select("#{@pet1.name}")

    click_button "Submit my application"

    expect(page).to have_content("You must complete the Name, Address, City, State, Zip, Phone Number, Description fields")
    expect(current_path).to eq("/apps/new")

    fill_in :address, with: "1234 st"

    click_button "Submit my application"

    expect(page).to have_content("You must complete the Name, City, State, Zip, Phone Number, Description fields")
    expect(current_path).to eq("/apps/new")

  end
end
