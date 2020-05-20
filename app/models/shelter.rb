class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def self.shelter_list(params)

    if params[:alphabetical] == "true"
      order("lower(name)")
    elsif params[:num_pets] == "true"
      Shelter.joins("left join pets on pets.shelter_id = shelters.id").group(:id).order("count(pets) desc")
    else
      all
    end
  end

  def pending?
    pets.any? {|pet| pet.adoptable == false}
  end

  def average_review_rating
    return "n/a" if reviews.empty?
    reviews.average(:rating).round(1)
  end

  def app_count
    pet_ids = pets.pluck(:id)
    PetApp.where(pet_id: pet_ids).select(:app_id).distinct.count
  end

end
