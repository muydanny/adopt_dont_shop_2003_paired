class App < ApplicationRecord

  has_many :pet_apps
  has_many :pets, through: :pet_apps

end
