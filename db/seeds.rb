# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter1 = Shelter.create(
  name: "the lab",
  address: "666 dog Ave",
  city: "ruff town",
  state: "DG",
  zip: "12345"
)
pet1 = Pet.create(
  name: "Walter",
  age: "4",
  sex: "male",
  description: "a bit mischevious",
  image: "https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg",
  shelter_id: shelter1.id
)
