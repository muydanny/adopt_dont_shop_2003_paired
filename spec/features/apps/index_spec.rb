require 'rails_helper'

RSpec.describe "Application index page", type: :feature do
  before :each do
   @shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")
   @shelter2 = Shelter.create(name: "S2", address: "A2",city: "C2",state: "ST",zip: "12345")
   @shelter3 = Shelter.create(name: "S3", address: "A3",city: "C3",state: "ST",zip: "12345")

   @pet1 = @shelter1.pets.create(name: "P1",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
   @pet11 = @shelter1.pets.create(name: "P11",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
   @pet111 = @shelter1.pets.create(name: "P111",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
   @pet2 = @shelter2.pets.create(name: "P2",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
   @pet22 = @shelter2.pets.create(name: "P22",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
   @pet222 = @shelter2.pets.create(name: "P222",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
   @pet3 = @shelter3.pets.create(name: "P3",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)

   @app1 = App.create(name:"A1X", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
   @app11 = App.create(name:"A11", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
   @app2 = App.create(name:"A2", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")

   PetApp.create(pet: @pet1, app: @app1)
   PetApp.create(pet: @pet1, app: @app11)
   PetApp.create(pet: @pet11, app: @app1)
   PetApp.create(pet: @pet111, app: @app11)
   PetApp.create(pet: @pet2, app: @app2)
   PetApp.create(pet: @pet22, app: @app2)
 end

  it "view all applications for individual pet" do

    visit "/pets/#{@pet1.id}"
    click_link("View Applications")
    expect(current_path).to eq("/pets/#{@pet1.id}/apps")

    within("#app-#{@app1.id}") do
      expect(page).to have_content(@app1.name)
      expect(page).to have_css(".pet-link")
      expect(page).to_not have_content(@app11.name)
    end

    within("#app-#{@app11.id}") do
      expect(page).to have_content(@app11.name)
      expect(page).to_not have_content(@app1.name)
      click_link("#{@app11.name}")
    end

    expect(current_path).to eq("/apps/#{@app11.id}")
  end
end

# When I visit a pets show page
# I see a link to view all applications for this pet
# When I click that link
# I can see a list of all the names of applicants for this pet
# Each applicant's name is a link to their application show page
