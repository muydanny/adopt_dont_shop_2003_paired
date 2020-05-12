class PetsController < ApplicationController

  def index
    @pets = Pet.pet_list(params)
    @shelter = Shelter.find(params[:id]) if !params[:id].nil?
    # @favorite = Favorite.new(session[:favorite])

  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    pet = shelter.pets.create!(pet_params)

    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def show
    @pet = Pet.find(params[:id])
    @shelter = Shelter.where(name: @pet.shelter)
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update!(pet_params)

    redirect_to '/pets'
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def is_adoptable
    @pet = Pet.find(params[:id])
    @pet.update({
      adoptable: true
      })
    redirect_to "/pets/#{@pet.id}"
  end

  def is_pending
    @pet = Pet.find(params[:id])
    @pet.update({
      adoptable: false
      })
    redirect_to "/pets/#{@pet.id}"
  end

  private

  def pet_params
    params.permit(:name,
                  :image,
                  :description,
                  :age,
                  :sex,
                  :adoptable)
  end


end
