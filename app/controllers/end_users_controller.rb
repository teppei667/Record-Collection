class EndUsersController < ApplicationController

  def mypage
    @records = Record.where(end_user_id: current_end_user.id).order(created_at: :desc)
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
    #DM機能
    if end_user_signed_in?
      @currentEndUserEntry = Entry.where(end_user_id: current_end_user.id)
      @endUserEntry = Entry.where(end_user_id: @end_user.id)
      unless @end_user.id == current_end_user.id
        @currentEndUserEntry.each do |c|
          @endUserEntry.each do |e|
            if c.room_id == e.room_id then
              @isRoom = true
              @roomId = c.room_id
            end
          end
        end
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
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
    params.require(:end_user).permit(:name, :introduction, :email, :profile_image)
  end
end
