class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_favorite#, only: [:new, :create]

  add_flash_types :error

  private

   def get_favorite
     @favorite = Favorite.new(session[:favorite])
   end

end
