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

   @app1 = App.create(name:"A1X", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
   @app11 = App.create(name:"A11", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
   @app2 = App.create(name:"A2", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
   @app22 = App.create(name:"A2X", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")

   PetApp.create(pet: @pet1, app: @app1, approved:false)
   PetApp.create(pet: @pet1, app: @app11, approved:false)
   PetApp.create(pet: @pet11, app: @app1, approved:false)
   PetApp.create(pet: @pet111, app: @app11, approved:false)
   PetApp.create(pet: @pet2, app: @app2, approved:false)
   PetApp.create(pet: @pet22, app: @app2, approved:false)
 end

 it "can visit and delete all_apps" do

   visit "/apps/all"

   app_ids = App.pluck(:id)
   expect(app_ids.include?(@app1.id)).to eq(true)
   expect(app_ids.include?(@app11.id)).to eq(true)

   within("#app-#{@app1.id}")do
     click_button ("Delete App")
   end

   app_ids = App.pluck(:id)
   expect(app_ids.include?(@app1.id)).to eq(false)
   expect(app_ids.include?(@app11.id)).to eq(true)

 end


end
