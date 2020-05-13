class FavoritesController < ApplicationController

  def index
    @favorite_pets = @favorite.favorite_pets
  end

  def update
    pet = Pet.find(params[:pet_id])
    @favorite = Favorite.new(session[:favorite])
    if session[:favorite].nil? || session[:favorite][pet.id.to_s].nil?
      @favorite.add_pet(pet.id)
      session[:favorite] = @favorite.contents
      quantity = @favorite.count_of(pet.id)
      flash[:notice] = "You have added #{pet.name} to your favorites"
    end

    if params[:page] == "show"
      redirect_to "/pets/#{pet.id}"
    elsif params[:page] == "index"
      redirect_to "/pets"
    end
  end

  def destroy
    favorite = session[:favorite]
    pet = Pet.find(params[:pet_id])
    if pet
      favorite.delete(pet.id.to_s)
      flash[:notice] = "You have removed #{pet.name} from your favorites"
    end
    if params[:page] == "favorites"
      redirect_to '/favorites'
    elsif params[:page] == "show"
      redirect_to "/pets/#{pet.id}"
    elsif params[:page] == "index"
      redirect_to "/pets"
    end
  end

  def destroy_all
    reset_session
    redirect_to '/favorites'
  end


end
