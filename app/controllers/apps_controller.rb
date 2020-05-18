class AppsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
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
        PetApp.create(pet_id: id, app: @app)
        session[:favorite].delete(id.to_s)
      end

      flash[:notice] = "Your application for the selected pets has been submitted"
      redirect_to '/favorites'
    else
      flash[:notice] = "You must complete the order form"
      redirect_to '/apps/new'
    end
  end

  def update
    app = App.find(params[:app_id])
    pet = Pet.find(params[:id])
    if params[:approved] == "true"
    app.update({
      approved: "true"
      })
    pet.update({
      adoptable: false
      })
    else params[:approved] == "false"
      app.update({
        approved: "false"
        })
      pet.update({
        adoptable: true
        })
      end
    redirect_to "/pets/#{pet.id}"
  end

  private

  def app_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip,
                  :phone_number,
                  :description,
                  :approved
                  )
  end

end
