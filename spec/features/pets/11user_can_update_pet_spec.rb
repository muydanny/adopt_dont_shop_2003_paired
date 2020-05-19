require 'rails_helper'

RSpec.describe "pet update ", type: :feature do
  before :each do
    @shelter1 = Shelter.create(
      name: "the lab",
      address: "123 Dog Street",
      city: "Dog Town",
      state: "DO",
      zip: "12345"
    )
    @shelter2 = Shelter.create(
      name: "Barks and Crafts",
      address: "456 Pup Place",
      city: "Newfoundland",
      state: "PP",
      zip: "67890"
    )
    @pet1 = Pet.create(
      name: "Remy",
      age: "10",
      sex: "male",
      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg",
      shelter_id: @shelter2.id
    )

  end
  it "can update a pet" do

    visit "/pets/#{@pet1.id}/edit"

    fill_in "name", with: "Goose"
    fill_in "description", with: "hell of a wingman"
    fill_in "image", with: "https://ih1.redbubble.net/image.489763103.8167/flat,750x1000,075,f.u2.jpg"
    fill_in "age", with: "4"
    # choose("sex")
    click_button "Update Pet"

    click_link "Goose"
    expect(page).not_to have_content(@pet1.name)
    # expect(page).not_to have_content(@pet1.age)
    # expect(page).not_to have_content(pet1.sex)
    expect(page).not_to have_content(@shelter1.name)
    expect(page).not_to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")

    expect(page).to have_content("Goose")
    expect(page).to have_content("hell of a wingman")
    expect(page).to have_content("4")
    # expect(page).to have_content("female")
    expect(page).to have_content("Barks and Crafts")
    expect(page).to have_css("img[src*='https://ih1.redbubble.net/image.489763103.8167/flat,750x1000,075,f.u2.jpg']")
  end

  it "can update a pet from shelter pet index" do
    visit "/shelters/#{@shelter2.id}/pets"

    click_link("Update Pet")
    expect(current_path).to eq("/pets/#{@pet1.id}/edit")
    # expect(page).to have_link(href: "/pets/#{pet1.id}/edit")
  end

  it "can update a pet from pet index" do

    visit "/pets"

    click_link("Update Pet")

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")
  end
  it "can update a pet from pet show" do

    visit "/pets/#{@pet1.id}"

    click_link("Update Pet")

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")
  end




end
