class FavoritesController < ApplicationController

  def create
    record = Record.find(params[:record_id])
    favorite = current_end_user.favorites.new(record_id: record.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    record = Record.find(params[:record_id])
    favorite = current_end_user.favorites.find_by(record_id: record.id)
    favorite.destroy
    redirect_to request.referer
  end
end
