class FavoritesController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @record = Record.find(params[:record_id])
    favorite = current_end_user.favorites.new(record_id: @record.id)
    favorite.save
  end

  def destroy
    @record = Record.find(params[:record_id])
    favorite = current_end_user.favorites.find_by(record_id: @record.id)
    favorite.destroy
  end
end
