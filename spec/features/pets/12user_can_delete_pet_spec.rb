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
    @pet1 = Pet.create(
      name: "Remy",
      age: "1999",
      sex: "male",
      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg",
      shelter_id: @shelter1.id,
      adoptable: true
    )

  end
  it "can delete a pet from show" do

    visit "/pets/#{@pet1.id}"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.shelter.name)
    expect(page).to have_content(@pet1.age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")
    expect(page).to have_content(@pet1.adoption_status)
    click_button("Delete #{@pet1.name}")

    expect(page).not_to have_content(@pet1.name)
    expect(page).not_to have_content(@pet1.age)
    # expect(page).not_to have_content(@pet1.sex)
    # expect(page).not_to have_content(@pet1.shelter)
    expect(page).not_to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")

  end

  it "can delete pets from shelter pet index" do

    visit "/shelters/#{@shelter1.id}/pets"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.shelter.name)
    expect(page).to have_content(@pet1.age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")
    click_button("Delete #{@pet1.name}")

    expect(page).not_to have_content(@pet1.name)
    expect(page).not_to have_content(@pet1.age)
    # expect(page).not_to have_content(@pet1.sex)
    expect(page).not_to have_content(@pet1.shelter)
    expect(page).not_to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")

  end

  it "can delete pets from pet index" do

    visit "/pets"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.shelter.name)
    expect(page).to have_content(@pet1.age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")
    click_button("Delete #{@pet1.name}")

    expect(page).not_to have_content(@pet1.name)
    expect(page).not_to have_content(@pet1.age)
    # expect(page).not_to have_content(@pet1.sex)
    expect(page).not_to have_content(@pet1.shelter)
    expect(page).not_to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")

  end

  it "cannot delete pets with approved apps (pending adoption status) from show" do
    shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")

    pet100 = shelter1.pets.create(name: "P100",age: "1",sex: "male",description: "d1",image: "i1",adoptable: false)
    pet110 = shelter1.pets.create(name: "P110",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet111 = shelter1.pets.create(name: "P111",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)

    app100 = App.create(name:"A100", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
    app111 = App.create(name:"A111", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")

    PetApp.create(pet: pet100, app: app100, approved: true)
    PetApp.create(pet: pet100, app: app111, approved: true)
    PetApp.create(pet: pet110, app: app100, approved: false)

    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet100.id)).to eq(true)
    expect(pet_ids.include?(pet110.id)).to eq(true)
    expect(pet_ids.include?(pet111.id)).to eq(true)

    visit "/pets/#{pet100.id}"

    within(".delete-form")do

      expect(pet100.adoptable).to eq(false)
      expect(page).to have_content("Cannot delete pet with approved applications")
      expect(page).not_to have_button("Delete #{pet100.name}")
    end

    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet100.id)).to eq(true)

    visit "/pets/#{pet110.id}"

    within(".delete-form")do
    expect(pet110.adoptable).to eq(true)
      expect(page).not_to have_content("Cannot delete pet with approved applications")
      click_button("Delete #{pet110.name}")
    end

    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet110.id)).to eq(false)

    visit "/pets/#{pet111.id}"

    within(".delete-form")do
      expect(pet111.adoptable).to eq(true)
      expect(page).not_to have_content("Cannot delete pet with approved applications")
      click_button("Delete #{pet111.name}")
    end

    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet100.id)).to eq(true)
    expect(pet_ids.include?(pet110.id)).to eq(false)
    expect(pet_ids.include?(pet111.id)).to eq(false)

  end

  it "cannot delete pets with approved apps (pending adoption status) from index" do
    shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")

    pet100 = shelter1.pets.create(name: "P100",age: "1",sex: "male",description: "d1",image: "i1",adoptable: false)
    pet110 = shelter1.pets.create(name: "P110",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet111 = shelter1.pets.create(name: "P111",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)

    app100 = App.create(name:"A100", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
    app111 = App.create(name:"A111", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")

    PetApp.create(pet: pet100, app: app100)
    PetApp.create(pet: pet100, app: app111)
    PetApp.create(pet: pet110, app: app100)

    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet100.id)).to eq(true)
    expect(pet_ids.include?(pet110.id)).to eq(true)
    expect(pet_ids.include?(pet111.id)).to eq(true)

    visit "/pets"

    within("#pet-#{pet100.id}")do
      expect(pet100.adoptable).to eq(false)
      expect(page).to have_content("Cannot delete pet with approved applications")
      expect(page).not_to have_button("Delete #{pet100.name}")
    end

    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet100.id)).to eq(true)

    within("#pet-#{pet110.id}")do
    expect(pet110.adoptable).to eq(true)
      expect(page).not_to have_content("Cannot delete pet with approved applications")
      click_button("Delete #{pet110.name}")
    end

    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet110.id)).to eq(false)

    within("#pet-#{pet111.id}")do
      expect(pet111.adoptable).to eq(true)
      expect(page).not_to have_content("Cannot delete pet with approved applications")
      click_button("Delete #{pet111.name}")
    end

    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet100.id)).to eq(true)
    expect(pet_ids.include?(pet110.id)).to eq(false)
    expect(pet_ids.include?(pet111.id)).to eq(false)

  end

  it "deleting pets pets deletes them from favorites" do
    shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")

    pet100x = shelter1.pets.create(name: "P100x",age: "1",sex: "male",description: "d1",image: "i1",adoptable: false)
    pet110x = shelter1.pets.create(name: "P110x",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet111x = shelter1.pets.create(name: "P111x",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)

    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet100x.id)).to eq(true)
    expect(pet_ids.include?(pet110x.id)).to eq(true)
    expect(pet_ids.include?(pet111x.id)).to eq(true)

    visit "/pets"
    expect(page).to have_css(".favorite_indicator", text: 0)
    within("#fav-#{pet111x.id}") do
      click_button "Add #{pet111x.name} to favorites"
    end
    expect(page).to have_content("You have added #{pet111x.name} to your favorites")
    expect(page).to have_css(".favorite_indicator", text: 1)

    within("#fav-#{pet100x.id}") do
      click_button "Add #{pet100x.name} to favorites"
    end
    expect(page).to have_content("You have added #{pet100x.name} to your favorites")
    expect(page).to have_css(".favorite_indicator", text: 2)

    expect(current_path).to eq("/pets")
    within("#pet-#{pet111x.id}")do
      within(".delete-form")do
        click_button("Delete P111x")
      end
    end
    pet_ids = Pet.pluck(:id)
    expect(pet_ids.include?(pet100x.id)).to eq(true)
    expect(pet_ids.include?(pet110x.id)).to eq(true)
    expect(pet_ids.include?(pet111x.id)).to eq(false)
    expect(page).to have_css(".favorite_indicator", text: 1)






  end



end
