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
      flash[:notice] = "You must fill out #{empty_params}"
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
      flash[:notice] = "You must fill out #{empty_params}"
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

  def empty_params
    empty_params = []
    empty_params << "Name" if params[:name] == ""
    empty_params << "Address" if params[:address] == ""
    empty_params << "City" if params[:city] == ""
    empty_params << "State" if params[:state] == ""
    empty_params << "Zip" if params[:zip] == ""
    empty_params.join(", ")
  end



end
