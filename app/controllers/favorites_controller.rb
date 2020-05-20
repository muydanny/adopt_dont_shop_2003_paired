class FavoritesController < ApplicationController

  def index
    @favorite_pets = favorite.favorite_pets
    @apps = App.all
    @pets = Pet.all
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite = Favorite.new(session[:favorite])
    if session[:favorite].nil? || session[:favorite][pet.id.to_s].nil?
      favorite.add_pet(pet.id)
      session[:favorite] = favorite.contents
      quantity = favorite.count_of(pet.id)
      flash[:notice] = "You have added #{pet.name} to your favorites"
    end
    redirect_back(fallback_location: "/pets")
  end

  def destroy
    favorite = session[:favorite]
    pet = Pet.find(params[:pet_id])
    if pet
      favorite.delete(pet.id.to_s)
      flash[:notice] = "You have removed #{pet.name} from your favorites"
    end
    redirect_back(fallback_location:"/favorites")
  end

  def destroy_all
    reset_session
    redirect_to '/favorites'
  end


end
