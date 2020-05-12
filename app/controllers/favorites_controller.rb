class FavoritesController < ApplicationController

  def index

  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:favorite] ||= Hash.new(0)
    session[:favorite][pet_id_str] ||= 0
    session[:favorite][pet_id_str] = session[:favorite][pet_id_str] + 1
    quantity = session[:favorite][pet_id_str]
    flash[:notice] = "You have added #{pet.name} to your favorites"
    redirect_to '/pets'
  end


end
