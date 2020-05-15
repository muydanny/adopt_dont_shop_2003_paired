require 'rails_helper'

RSpec.describe App, type: :model do

  describe "relationships" do

  it {should have_many :pet_apps}
  it {should have_many(:pets).through(:pet_apps)}

  end
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :description}

  end

  it "returns list of all application pet names" do
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

    app1 = App.create(name:"A1", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
    app111 = App.create(name:"A111", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
    app2 = App.create(name:"A2", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")

    PetApp.create(pet: pet1, app: app1)
    PetApp.create(pet: pet1, app: app111)
    PetApp.create(pet: pet11, app: app1)
    PetApp.create(pet: pet111, app: app111)
    PetApp.create(pet: pet2, app: app2)
    PetApp.create(pet: pet22, app: app2)

    expect(app1.pets_list).to eq("P1, P11")
    expect(app111.pets_list).to eq("P1, P111")
    expect(app2.pets_list).to eq("P2, P22")
  end
end
