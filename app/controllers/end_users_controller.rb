class EndUsersController < ApplicationController

  def mypage
    @records = Record.where(end_user_id: current_end_user.id)
  end

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

#current_end_userのお気に入り一覧ページ
  def my_favorite
    @end_user = EndUser.find(params[:id])
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:record_id)
    @favorite_records = Record.find(favorites)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
   end_user = EndUser.find(params[:id])
   end_user.update(end_user_params) ? (redirect_to end_user_path(end_user.id)) : (render :edit)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :email)
  end
end
