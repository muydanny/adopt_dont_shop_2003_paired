class AppsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
  end

  def all
    @apps = App.all
  end

  def new
    @favorite_pets = favorite.favorite_pets
  end

  def show
    @app = App.find(params[:id])
  end

  def create
    @app = App.create(app_params)

    if @app.save
      params[:pet_ids].each do |id|
        PetApp.create(pet_id: id, app_id: @app.id, approved: false)
        session[:favorite].delete(id.to_s)
      end

      flash[:notice] = "Your application for the selected pets has been submitted"
      redirect_to '/favorites'
    else
      flash[:notice] = "You must complete the #{empty_params} fields"
      redirect_to '/apps/new'
    end
  end

  def update
    pet = Pet.find(params[:id])
    pet_app = PetApp.where(pet_id: pet.id).first
    # app = App.where(id: pet_app.app_id).first
    app = App.find(pet_app.app_id)
    if params[:approved] == "true"
    pet_app.update({
      approved: true
      })
    pet.update({
      adoptable: false
      })
      redirect_to "/pets/#{pet.id}"
    else params[:approved] == "false"
      pet_app.update({
        approved: false
        })
      pet.update({
        adoptable: true
        })
      # redirect_to "/pets/#{pet.id}"
      redirect_back(fallback_location: "/apps/#{app.id}" )
    end
  end

  def destroy
    App.destroy(params[:id])
    redirect_to '/apps/all'
  end

  private

  def app_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip,
                  :phone_number,
                  :description
                  )
  end

  def empty_params
    empty_params = []
    empty_params << "Name" if params[:name] == ""
    empty_params << "Address" if params[:address] == ""
    empty_params << "City" if params[:city] == ""
    empty_params << "State" if params[:state] == ""
    empty_params << "Zip" if params[:zip] == ""
    empty_params << "Phone Number" if params[:phone_number] == ""
    empty_params << "Description" if params[:description] == ""
    empty_params.join(", ")
  end

end
