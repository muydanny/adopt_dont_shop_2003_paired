class App < ApplicationRecord

  has_many :pet_apps
  has_many :pets, through: :pet_apps

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :description

end
