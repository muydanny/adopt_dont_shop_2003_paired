class AppsController < ApplicationController

  def new
    @favorite_pets = @favorite.favorite_pets
  end

  def create
    binding.pry
  end

end
