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

      # @shelters = Shelter.joins(:pets).distinct
      # @pets = Pet.group(:shelter_id).count
      # x = Pet.group(:shelter).count
      # binding.pry
      Shelter.joins("left join pets on pets.shelter_id = shelters.id").group(:id).order("count(pets) desc")
      # all.sort_by {|shelter| shelter.pets.count}.reverse
      # x = Pet.group(:shelter).order(:shelter_id).reverse_order.count(:shelter_id)
      # x.keys
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
    count = 0
    pets.each do |pet|
      count += pet.apps.uniq.count
    end
    count
  end

end
