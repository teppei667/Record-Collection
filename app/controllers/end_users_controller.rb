class EndUsersController < ApplicationController

  before_action :authenticate_end_user!
  before_action :ensure_correct_user, only: [:edit, :update, :my_favorite]

  def mypage
    @end_user = EndUser.find(params[:id])
    @records = Record.where(end_user_id: @end_user.id).order(created_at: :desc)
  end

  def index
    @end_users = EndUser.all
  end

  def end_user_search
    @end_users = EndUser.end_user_search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  def show
    @end_user = EndUser.find(params[:id])
    @records = Record.where(end_user_id: @end_user.id).order(created_at: :desc).limit(6)
    @my_favorites = Favorite.where(end_user_id: current_end_user.id)
    # DM機能
    @room_id = (@end_user.entries.pluck(:room_id) & current_end_user.entries.pluck(:room_id)).first
    @room, @entry = Room.new, Entry.new unless @room_id
  end

  # current_end_userのお気に入り一覧ページ
  def my_favorite
    @end_user = EndUser.find(params[:id])
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:record_id)
    @favorite_records = Record.find(favorites)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    @end_user.update(end_user_params) ? (redirect_to end_user_path(@end_user.id)) : (render :edit)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :email, :profile_image)
  end

  def ensure_correct_user
    @end_user = EndUser.find(params[:id])
    if @end_user != current_end_user
      redirect_to mypage_path(current_end_user.id)
    end
  end

end
