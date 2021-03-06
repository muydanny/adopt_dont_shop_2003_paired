class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_apps, dependent: :destroy
  has_many :apps, through: :pet_apps

  validates_presence_of :name
  validates_presence_of :image
  validates_presence_of :age

  def adoption_status
    return "Adoptable" if adoptable
    return "Pending" if !adoptable
  end

  def self.pet_list(params)

    if !params[:id].nil? && params[:adoptable] == "true"
      where(adoptable: true).where(shelter_id: params[:id]).order(:adoptable).reverse_order
    elsif !params[:id].nil? && params[:adoptable] == "false"
      where(adoptable: false).where(shelter_id: params[:id]).order(:adoptable).reverse_order
    elsif params[:adoptable] == "true"
    # if params[:adoptable] == "true"
      where(adoptable: true)
    elsif params[:adoptable] == "false"
      where(adoptable: false)
    elsif !params[:id].nil?
      where(shelter_id: params[:id]).order(:adoptable).reverse_order
    else
      order(:adoptable).reverse_order
    end
  end

  def on_hold_for
    pet_app = PetApp.where(pet_id: id).first
    if pet_app.approved
      app_name = App.find(pet_app.app_id)
    else
      nil
    end
  end

  def approved
    PetApp.where(pet_id: id).where(approved: :true).exists?
  end

  def self.approved_pets
    pet_ids = PetApp.where(approved: :true).pluck(:pet_id)
    Pet.find(pet_ids)
  end
end
