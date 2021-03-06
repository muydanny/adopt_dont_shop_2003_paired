require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validates values" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :image}
    # it {should validate_presence_of :description}
    it {should validate_presence_of :age}
    # it {should belong_to :favorites}

  end
  describe "relationships" do

  it {should belong_to :shelter}
  it {should have_many :pet_apps}
  it {should have_many(:apps).through(:pet_apps)}

  end

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
      address: "123 cat Street",
      city: "cat Town",
      state: "CT",
      zip: "99999"
    )

    @pet1 = Pet.create(
      name: "Remy",
      description: "I'll be honest, he's a killer",
      age: "10",
      sex: "male",
      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg",
      shelter_id: @shelter1.id,
      adoptable: false
    )

    @pet2 = Pet.create(
      name: "Abu",
      description: "not a theif",
      age: "22",
      sex: "male",
      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg",
      shelter_id: @shelter1.id,
      adoptable: true
    )
    @pet3 = Pet.create(
      name: "Flounder",
      description: "a fish",
      age: "5",
      sex: "male",
      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg",
      shelter_id: @shelter1.id,
      adoptable: false
    )
    @pet4= Pet.create(
      name: "Codsworth",
      description: "a clock with knowedge of baroque art",
      age: "55",
      sex: "male",
      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg",
      shelter_id: @shelter2.id,
      adoptable: true
    )
  end

  it "returns adoptable or pending" do
    expect(@pet2.adoption_status).to eq("Adoptable")
    expect(@pet1.adoption_status).to eq("Pending")
  end

  it "can list adoptable pets on pet index" do
    params = {:adoptable => "true"}
    expect(Pet.pet_list(params)).to eq([@pet2, @pet4])
  end

  it "can list adoption pending pets on pet index" do
    params = {:adoptable => "false"}
    expect(Pet.pet_list(params)).to eq([@pet1, @pet3])
  end

  it "can list pets by adoptable first on pet index" do
    params = {}
    expect(Pet.pet_list(params)).to eq([@pet2, @pet4, @pet1, @pet3])
  end

  it "can list pets by shelter, adoptable first" do
    params = {:id => @shelter1.id}
    expect(Pet.pet_list(params)).to eq([@pet2, @pet1, @pet3])
  end

  it "can list adoptable pets on shelter pet index" do
    params = {:id => @shelter1.id, :adoptable => "true"}
    expect(Pet.pet_list(params)).to eq([@pet2])
  end

  it "can list pending adoption pets on shelter pet index" do
    params = {:id => @shelter1.id, :adoptable => "false"}
    expect(Pet.pet_list(params)).to eq([@pet1, @pet3])
  end

  it "has on hold text" do
    @shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")
    @pet1 = @shelter1.pets.create(name: "P1",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    @pet11 = @shelter1.pets.create(name: "P11",age: "1",sex: "male",description: "d1",image: "i1",adoptable: false)
    @app1 = App.create(name:"A1", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
    @app111 = App.create(name:"A111", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
    PetApp.create(pet: @pet1, app: @app1, approved: false)
    PetApp.create(pet: @pet1, app: @app111, approved: false)
    PetApp.create(pet: @pet11, app: @app1, approved: true)

    expect(@pet11.on_hold_for.name).to eq("A1")
    expect(@pet1.on_hold_for).to eq(nil)
  end

  it "returns if its approved" do
    @shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")
    @pet1 = @shelter1.pets.create(name: "P1",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    @pet11 = @shelter1.pets.create(name: "P11",age: "1",sex: "male",description: "d1",image: "i1",adoptable: false)
    @app1 = App.create(name:"A1", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
    @app111 = App.create(name:"A111", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
    @pet_app1 = PetApp.create(pet: @pet1, app: @app1, approved: false)
    @pet_app2 = PetApp.create(pet: @pet1, app: @app111, approved: false)
    @pet_app3 = PetApp.create(pet: @pet11, app: @app1, approved: true)
    expect(@pet11.approved).to eq(true)
    expect(@pet1.approved).to eq(false)
  end

  it "returns approved pets"do
  @shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")
  @pet1 = @shelter1.pets.create(name: "P1",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
  @pet11 = @shelter1.pets.create(name: "P11",age: "1",sex: "male",description: "d1",image: "i1",adoptable: false)
  @pet111 = @shelter1.pets.create(name: "P111",age: "1",sex: "male",description: "d1",image: "i1",adoptable: false)
  @app1 = App.create(name:"A1", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
  @app111 = App.create(name:"A111", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc")
  expect(Pet.approved_pets).to eq([])
  @pet_app1 = PetApp.create(pet: @pet1, app: @app1, approved: false)
  @pet_app2 = PetApp.create(pet: @pet1, app: @app111, approved: false)
  @pet_app3 = PetApp.create(pet: @pet11, app: @app1, approved: true)
  @pet_app3 = PetApp.create(pet: @pet111, app: @app1, approved: true)

  expect(Pet.approved_pets).to eq([@pet11, @pet111])
  @pets = Pet.all
  expect(@pets.approved_pets).to eq([@pet11, @pet111])
  end


end
