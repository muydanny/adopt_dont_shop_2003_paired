class PetsController < ApplicationController

  def index
    @pets = Pet.pet_list(params)
    @shelter = Shelter.find(params[:id]) if !params[:id].nil?
    # binding.pry
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    pet = shelter.pets.create(pet_params)

    if pet.save
      flash[:notice] = "#{pet.name} has been created!"
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:notice] = "You must fill out #{empty_params}"
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
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
    pet.update(pet_params)

    redirect_to '/pets'
  end

  def destroy
    pet_id = params[:id]

    if !session[:favorite].nil?
      session[:favorite].delete(pet_id.to_s)
    end

    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def adoptable
    @pet = Pet.find(params[:id])
    @pet.update({
      adoptable: true
      })
    redirect_to "/pets/#{@pet.id}"
  end

  def pending
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

  def empty_params
    empty_params = []
    empty_params << "Name" if params[:name] == ""
    empty_params << "Age" if params[:age] == ""
    empty_params << "Image" if params[:image] == ""
    empty_params.join(", ")
  end


end
