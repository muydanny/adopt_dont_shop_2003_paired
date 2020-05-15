class SheltersController < ApplicationController

  def index
    @shelters = Shelter.shelter_list(params)
    @pets = Pet.all
  end

  def new

  end

  def create

    shelter = Shelter.create(shelter_params)

    if shelter.save
      flash[:notice] = "You have created #{shelter.name}"
      redirect_to '/shelters'
    else
      flash[:notice] = "You must fill out all fields"
      redirect_to "/shelters/new"
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])

    shelter.update(shelter_params)
    if shelter.save
      flash[:notice] = "You have updated #{shelter.name}"
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "You must fill out all fields"
      redirect_to "/shelters/#{shelter.id}/edit"
    end
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  private

  def shelter_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip)
  end

end
