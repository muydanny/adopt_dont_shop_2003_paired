require 'rails_helper'

RSpec.describe "Shleters index page", type: :feature do
  before :each do
    @shelter1 = Shelter.create(
      name: "the lab",
      address: "123 Dog Street",
      city: "Dog Town",
      state: "DO",
      zip: "12345"
    )
    @shelter2 = Shelter.create(
      name: "starter kit-en",
      address: "999 Felix Ave",
      city: "Cat Alley",
      state: "CA",
      zip: "67890"
    )

    @pet1 = Pet.create(
      name: "many pets",
      age: "4",
      sex: "male",
      description: "a bit mischevious",

      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg",
      shelter_id: @shelter2.id,
      adoptable: true
    )

    @pet2 = Pet.create(
      name: "Penny",
      age: "55",
      sex: "female",
      description: "known to eat goose poop",

      image: "https://www.rover.com/blog/wp-content/uploads/2019/05/puppy-in-bowl.jpg",
      shelter_id: @shelter2.id,
      adoptable: true
    )
  end
  it "can see shelter names" do


    visit "/shelters"

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter2.name)
  end

  it "can list shelters by alphabetical order" do

    visit "/shelters"

    expect(page.all('h2')[-2]).to have_content(@shelter1.name)
    expect(page.all('h2')[-1]).to have_content(@shelter2.name)

    click_link("Sort Shelters by Alpbetical Order")

    expect(page.all('h2')[-1]).to have_content(@shelter1.name)
    expect(page.all('h2')[0]).to have_content(@shelter2.name)

  end

  it "can list shelters by number of pets" do


    visit "/shelters"


    expect(page.all('h2')[-2]).to have_content(@shelter1.name)
    #checkout orderly gem
    expect(page.all('h2')[-1]).to have_content(@shelter2.name)
    click_link("Sort Shelters by Number of Pets")

    expect(page.all('h2')[-1]).to have_content(@shelter1.name)
    expect(page.all('h2')[0]).to have_content(@shelter2.name)

  end

  it "lists shelter statistics" do
    shelter1 = create(:shelter)
    shelter2 = create(:shelter1)
    shelter3 = create(:shelter2)
    pet1 = create(:pet, shelter: shelter1)
    pet11 = create(:pet, shelter: shelter1)
    pet111 = create(:pet, shelter: shelter1)
    pet2 = create(:pet, shelter: shelter2)
    review1 = create(:review, :shelter) # 3 stars
    review11 = create(:review, :shelter) # 3 stars
    review111 = shelter1.reviews.create(title: "title1", rating: 4, content: "na", image: "img" )
    review2 = create(:review, :shelter) # 3 stars
    review111 = shelter2.reviews.create(title: "title1", rating: 4, content: "na", image: "img" )
    app1 = create(:app1)
    app2 = create(:app2)
binding.pry
  end


end
