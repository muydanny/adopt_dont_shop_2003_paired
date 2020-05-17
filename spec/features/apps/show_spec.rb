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

 it "link to approve app for pet, taken to pet show page, and status change" do

   visit "/apps/#{@app1.id}"
   expect(@pet1.adoptable).to eq(true)
   expect(@pet11.adoptable).to eq(true)
   expect(@app1.approved).to eq("false")

   expect(current_path).to eq("/apps/#{@app1.id}")

   within("#pet-#{@pet1.id}") do

     expect(page).to have_button("Approve Application")
   end

   within("#pet-#{@pet11.id}") do

     click_button "Approve Application"

   end
    expect(current_path).to eq("/pets/#{@pet11.id}")
    @pet11.reload
    @app1.reload
    expect(page).to have_content("Adoption status: Pending")
    expect(page).to have_content("On hold for #{@app1.name}")
    # expect(@app1.approved).to eq("true")
  end

  it "approve any number of pets on application" do
    visit "/pets/#{@pet1.id}"
    expect(page).to have_content("Adoption status: Adoptable")
    visit "/pets/#{@pet11.id}"
    expect(page).to have_content("Adoption status: Adoptable")
    visit "/apps/#{@app1.id}"

    expect(current_path).to eq("/apps/#{@app1.id}")

    within("#pet-#{@pet1.id}") do

      click_button "Approve Application"
    end
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Adoption status: Pending")
    expect(page).to have_content("On hold for #{@app1.name}")
    visit "/apps/#{@app1.id}"
    within("#pet-#{@pet11.id}") do

      click_button "Approve Application"

    end
     expect(current_path).to eq("/pets/#{@pet11.id}")
     @pet11.reload
     @app1.reload
     expect(page).to have_content("Adoption status: Pending")
     expect(page).to have_content("On hold for #{@app1.name}")
   end

   it "can not approve any other apps for pet" do
     visit "/apps/#{@app1.id}"
     expect(current_path).to eq("/apps/#{@app1.id}")

     within("#pet-#{@pet1.id}") do
       expect(page).to_not have_content("Can not approve application")
       click_button "Approve Application"
     end

     visit "/apps/#{@app111.id}"
     expect(current_path).to eq("/apps/#{@app111.id}")

     within("#pet-#{@pet1.id}") do
       expect(page).to have_content("Can not approve application")
       expect(page).to_not have_button("Approve Application")
     end
   end

   it "can revoke an application" do

     visit "/apps/#{@app1.id}"
     expect(@pet1.adoptable).to eq(true)
     expect(@app1.approved).to eq("false")

     expect(current_path).to eq("/apps/#{@app1.id}")

     within("#pet-#{@pet1.id}") do
       expect(page).to_not have_button("Revoke Application")
       click_button("Approve Application")
     end

      expect(page).to have_content("Adoption status: Pending")
      expect(page).to have_content("On hold for #{@app1.name}")

      visit "/apps/#{@app1.id}"

      within("#pet-#{@pet1.id}") do
        expect(page).to_not have_button("Approve Application")
        click_button("Revoke Application")
      end
      expect(page).to have_content("Adoption status: Adoptable")
      expect(page).to_not have_content("On hold for #{@app1.name}")
    end

 end
