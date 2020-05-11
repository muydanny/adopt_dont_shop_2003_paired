require 'rails_helper'

RSpec.describe "Pets can be seen on index ", type: :feature do

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

  it "can view a pet" do

    visit "/pets"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_content(@pet1.shelter.name)
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg']")
  end

  it "can list only adoptable pets" do

    visit "/pets"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_content(@pet1.shelter.name)
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg']")

    expect(page).to have_content(@pet2.name)
    expect(page).to have_content(@pet2.age)
    expect(page).to have_content(@pet2.sex)
    expect(page).to have_content(@pet2.shelter.name)
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg']")

    click_link("Show Only Adoptable Pets")

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_content(@pet1.shelter.name)
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg']")


    expect(page).not_to have_content(@pet2.name)
    expect(page).not_to have_content(@pet2.age)
    # expect(page).not_to have_content(pet2.sex)
    # expect(page).not_to have_content(pet2.shelter.name)
    expect(page).not_to have_css("img[src*='https://www.rover.com/blog/wp-content/uploads/2019/05/puppy-in-bowl.jpg']")

  end

  it "can list only adoption pending pets" do

    visit "/pets"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_content(@pet1.shelter.name)
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg']")

    expect(page).to have_content(@pet2.name)
    expect(page).to have_content(@pet2.age)
    expect(page).to have_content(@pet2.sex)
    expect(page).to have_content(@pet2.shelter.name)
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg']")

    click_link("Show Only Adoption-Pending Pets")

    expect(page).to have_content(@pet2.name)
    expect(page).to have_content(@pet2.age)
    expect(page).to have_content(@pet2.sex)
    expect(page).to have_content(@pet2.shelter.name)
    expect(page).to have_css("img[src*='https://www.rover.com/blog/wp-content/uploads/2019/05/puppy-in-bowl.jpg']")


    expect(page).not_to have_content(@pet1.name)
    expect(page).not_to have_content(@pet1.age)
    # expect(page).not_to have_content(pet2.sex)
    # expect(page).not_to have_content(pet2.shelter.name)
    expect(page).not_to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg']")

  end

end
