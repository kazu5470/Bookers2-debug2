class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  
  def create
    Favorite.create(favorite_params)
    @book = Book.find(params[:book_id])
  end

  def destroy
    if favorite = Favorite.find_by(favorite_params)
      favorite.destroy
    end
    @book = Book.find(params[:book_id])
  end  
  
  private
  
  def favorite_params
    { book_id: params[:book_id], user_id: current_user.id }
  end
  
  
end
