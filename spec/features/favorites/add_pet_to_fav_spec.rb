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
      name: "Walter",
      age: "4",
      sex: "male",
      description: "a bit mischevious",
      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg",
      shelter_id: @shelter1.id,
      adoptable: true
    )
    @pet2 = Pet.create(
      name: "Penny",
      age: "55",
      sex: "female",
      description: "known to eat goose poop",

      image: "https://www.rover.com/blog/wp-content/uploads/2019/05/puppy-in-bowl.jpg",
      shelter_id: @shelter1.id,
      adoptable: false
    )
  end

  it "displays a message" do
    visit "/pets"

    within("#pet-#{@pet1.id}") do
      click_button "Add Pet to Favorites"
    end

    expect(page).to have_content("You have added #{@pet1.name} to your favorites")
  end

  it "displays the total number of favorite pets" do

    visit "/pets"


    expect(page).to have_css(".favorite_indicator", text: 0)

    within("#pet-#{@pet1.id}") do
      click_button "Add Pet to Favorites"
    end


    expect(page).to have_css(".favorite_indicator", text: 1)

    within("#pet-#{@pet2.id}") do
      click_button "Add Pet to Favorites"
    end

    expect(page).to have_css(".favorite_indicator", text: 2)

  end

  it "can only add 1 pet" do
    visit "/pets"


    expect(page).to have_css(".favorite_indicator", text: 0)

    within("#pet-#{@pet1.id}") do
      click_button "Add Pet to Favorites"
    end

    expect(page).to have_css(".favorite_indicator", text: 1)

    within("#pet-#{@pet1.id}") do
      click_button "Add Pet to Favorites"
    end


    expect(page).to have_content("You have already added #{@pet1.name} to your favorites")
    expect(page).to have_css(".favorite_indicator", text: 1)



end


end
