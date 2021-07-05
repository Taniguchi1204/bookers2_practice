class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    Favorite.find_by(user_id: current_user,book_id: @book.id).destroy
  end
end
