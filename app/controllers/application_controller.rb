class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_favorite#, only: [:new, :create]
  # helper_method :favorite
  add_flash_types :error

  private

   def get_favorite
     @favorite = Favorite.new(session[:favorite])
   end

   def favorite
     @favorite ||= Favorite.new(session[:favorite])
   end

end
