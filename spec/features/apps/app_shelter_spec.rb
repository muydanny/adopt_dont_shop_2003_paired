require 'rails_helper'

RSpec.describe "Shelter App relationsip", type: :feature do

    before :each do
      @shelter1 = Shelter.create(name: "Shelter 1111", address: "666 dog Ave", city: "ruff town", state: "DG", zip: "12345")
      @shelter2 = Shelter.create(name: "Shelter 2222", address: "999 pup st", city: "dog town", state: "DG", zip: "99999")
      @shelter3 = Shelter.create(name: "Shelter 3333", address: "1 hot st", city: "man town", state: "BP", zip: "55555")
      @pet1 = @shelter1.pets.create(name: "Dr. Dog", age: "4", sex: "male", description: "well educated", image: "https://i.redd.it/4ygdq7e6gze11.jpg", adoptable: true)
      @pet2 = @shelter2.pets.create(name: "Oreo", age: "55", sex: "female", description: "best if dipped in milk", image: "https://image.shutterstock.com/image-photo/cute-american-shorthair-cat-kitten-260nw-352176329.jpg", adoptable: true)
      @pet3 = @shelter2.pets.create(name: "Goose", age: "3", sex: "female", description: "loves chacing birds", image: "https://i.ytimg.com/vi/vObQY6sdiTo/maxresdefault.jpg", adoptable: true)
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

      select("#{@pet1.name}")
      select("#{@pet2.name}")
      select("#{@pet3.name}")
      fill_in :name, with: "Roger"
      fill_in :address, with: "101 Dalmation Plantation"
      fill_in :city, with: "London"
      fill_in :state, with: "UK"
      fill_in :zip, with: "10101"
      fill_in :phone_number, with: "101-101-1010"
      fill_in :description, with: "I'm a dog lover"

      click_button "Submit my application"
      @app = App.last

      expect(current_path).to eq("/favorites")
      expect(page).not_to have_css("##{@pet1.id}-info")
      expect(page).not_to have_css("##{@pet2.id}-info")
      expect(page).not_to have_css("##{@pet3.id}-info")
  end

  it "cannot delete shelter with 'Pending' app attached to pet" do

    visit "/shelters"

    within("#shelter-#{@shelter3.id}")do
      expect(page).to have_content("#{@shelter3.name}")
      click_button "Delete #{@shelter3.name}"
    end
    expect(page).not_to have_css("#shelter-#{@shelter3.id}")
    expect(page).not_to have_content("#{@shelter3.name}")
    @pet1[:adoptable] = true #shelter 1
    @pet2[:adoptable] = false #shelter 2
    @pet3[:adoptable] = true #shelter 2
    expect(@shelter1.pending?).to eq(false)
    expect(@shelter2.pending?).to eq(true)
    expect(@shelter3.pending?).to eq(false)

    within("#shelter-#{@shelter1.id}")do
      expect(page).to have_content("#{@shelter1.name}")
      expect(page).not_to have_content("shelters with adoption pending pets cannot be deleted")
      click_button "Delete #{@shelter1.name}"
    end
    expect(page).not_to have_css("#shelter-#{@shelter1.id}")
    expect(page).not_to have_content("#{@shelter1.name}")


    within("#shelter-#{@shelter2.id}")do
      expect(page).to have_content("#{@shelter2.name}")
      expect(page).not_to have_content("shelters with adoption pending pets cannot be deleted")
      click_button "Delete #{@shelter2.name}"
    end
    expect(page).not_to have_css("#shelter-#{@shelter2.id}")
    expect(page).not_to have_content("#{@shelter2.name}")

  end

  it "if a shelter is deleted, its pets are deleted" do
    visit "/shelters"
    pet_ids = Pet.pluck(:id)
    shelter_ids = Shelter.pluck(:id)

    expect(pet_ids.include?(@pet1.id)).to eq(true)
    expect(pet_ids.include?(@pet2.id)).to eq(true)
    expect(pet_ids.include?(@pet3.id)).to eq(true)
    expect(shelter_ids.include?(@shelter1.id)).to eq(true)
    expect(shelter_ids.include?(@shelter2.id)).to eq(true)
    expect(shelter_ids.include?(@shelter3.id)).to eq(true)

    within("#shelter-#{@shelter2.id}")do
      click_button "Delete #{@shelter2.name}"
    end

    # pet_ids = Pet.pluck(:id)
    pet_ids = Pet.pluck(:id)
    # shelter_ids = Shelter.pluck(:id)
    shelter_ids = Shelter.pluck(:id)

    expect(pet_ids.include?(@pet1.id)).to eq(true)
    expect(pet_ids.include?(@pet2.id)).to eq(false)
    expect(pet_ids.include?(@pet3.id)).to eq(false)
    expect(shelter_ids.include?(@shelter1.id)).to eq(true)
    expect(shelter_ids.include?(@shelter2.id)).to eq(false)
    expect(shelter_ids.include?(@shelter3.id)).to eq(true)

  end


end
