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
    shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")
    shelter2 = Shelter.create(name: "S2", address: "A2",city: "C2",state: "ST",zip: "12345")
    shelter3 = Shelter.create(name: "S3", address: "A3",city: "C3",state: "ST",zip: "12345")
    pet1 = shelter1.pets.create(name: "P1",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet11 = shelter1.pets.create(name: "P11",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet111 = shelter1.pets.create(name: "P111",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet2 = shelter2.pets.create(name: "P2",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet22 = shelter2.pets.create(name: "P22",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet222 = shelter2.pets.create(name: "P222",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet3 = shelter3.pets.create(name: "P3",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    review1 = shelter1.reviews.create(title: "R1", rating: 1, content: "na", image: "img" )
    review11 = shelter1.reviews.create(title: "R11", rating: 4, content: "na", image: "img" )
    review111 = shelter1.reviews.create(title: "R11", rating: 5, content: "na", image: "img" )
    review2 = shelter2.reviews.create(title: "R2", rating: 1, content: "na", image: "img" )
    review22 = shelter2.reviews.create(title: "R22", rating: 3, content: "na", image: "img" )
    review222 = shelter2.reviews.create(title: "R222", rating: 5, content: "na", image: "img" )
    app1 = App.create(name:"A1", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
    app111 = App.create(name:"A111", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
    app2 = App.create(name:"A2", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
    PetApp.create(pet: pet1, app: app1)
    PetApp.create(pet: pet1, app: app111)
    PetApp.create(pet: pet11, app: app1)
    PetApp.create(pet: pet111, app: app111)
    PetApp.create(pet: pet2, app: app2)
    PetApp.create(pet: pet22, app: app2)

    visit '/shelters'

    within("#shelter-#{shelter1.id}")do
      expect(page).to have_content("Pet Count: 3")
      expect(page).to have_content("Average Review Rating: 3.3")
      expect(page).to have_content("Application Count: 2")
    end
    within("#shelter-#{shelter2.id}")do
      expect(page).to have_content("Pet Count: 3")
      expect(page).to have_content("Average Review Rating: 3")
      expect(page).to have_content("Application Count: 1")

    end
    within("#shelter-#{shelter3.id}")do
      expect(page).to have_content("Pet Count: 1")
      expect(page).to have_content("Average Review Rating: n/a")
      expect(page).to have_content("Application Count: 0")
    end



  end


end
