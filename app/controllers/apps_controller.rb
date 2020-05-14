class AppsController < ApplicationController

  def new
    @favorite_pets = @favorite.favorite_pets
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
