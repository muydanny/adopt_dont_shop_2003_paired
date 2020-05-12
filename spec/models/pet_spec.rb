require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validates values" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :image}
    # it {should validate_presence_of :description}
    it {should validate_presence_of :age}
    # it {should belong_to :favorites}
    it {should belong_to :shelter}

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

end
