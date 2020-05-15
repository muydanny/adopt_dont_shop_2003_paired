require 'rails_helper'

RSpec.describe "When I visit an applications show page '/apps/:id'", type: :feature do
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

   @app1 = App.create(name:"A1", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
   @app111 = App.create(name:"A111", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
   @app2 = App.create(name:"A2", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")

   PetApp.create(pet: @pet1, app: @app1)
   PetApp.create(pet: @pet1, app: @app111)
   PetApp.create(pet: @pet11, app: @app1)
   PetApp.create(pet: @pet111, app: @app111)
   PetApp.create(pet: @pet2, app: @app2)
   PetApp.create(pet: @pet22, app: @app2)
 end

 it "I can see application attributes" do


   visit "/apps/#{@app1.id}"
   expect(current_path).to eq("/apps/#{@app1.id}")

   within("#app-#{@app1.id}") do
     expect(page).to have_content(@app1.name)
     expect(page).to have_content(@app1.address)
     expect(page).to have_content(@app1.city)
     expect(page).to have_content(@app1.state)
     expect(page).to have_content(@app1.zip)
     expect(page).to have_content(@app1.phone_number)
     expect(page).to have_content(@app1.description)
     expect(page).to have_content(@pet1.name)
     expect(page).to have_content(@pet11.name)
     expect(page).to_not have_content(@pet111.name)
     expect(page).to_not have_content(@app111.name)

     click_link(@pet1.name)

   end

    expect(current_path).to eq("/pets/#{@pet1.id}")

 end

end

# When I visit an applications show page "/applications/:id"
# I can see the following:
# - name
# - address
# - city
# - state
# - zip
# - phone number
# - Description of why the applicant says they'd
# be a good home for this pet(s)
# - names of all pet's that this application is
# for (all names of pets should be links to their show page)
