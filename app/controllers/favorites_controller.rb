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
    else
      flash[:notice] = "You have already added #{pet.name} to your favorites"
    end

    redirect_to '/pets'





    # pet = Pet.find(params[:pet_id])
    # pet_id_str = pet.id.to_s
    # session[:favorite] ||= Hash.new(0)
    # session[:favorite][pet_id_str] ||= 0
    # if session[:favorite][pet_id_str] == 0
    #   session[:favorite][pet_id_str] = session[:favorite][pet_id_str] + 1
    #   quantity = session[:favorite][pet_id_str]
    #   flash[:notice] = "You have added #{pet.name} to your favorites"
    # else
    #   flash[:notice] = "You have already added #{pet.name} to your favorites"
    # end
    #
    # redirect_to '/pets'
  end


end
