class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    Favorite.find_by(user_id: current_user,book_id: params[:book_id]).destroy
    redirect_to request.referer
  end
end