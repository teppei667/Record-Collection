class RelationshipsController < ApplicationController

  before_action :authenticate_end_user!

  def create
    current_end_user.follow(params[:end_user_id])
    redirect_to request.referer
  end

  def destroy
    current_end_user.unfollow(params[:end_user_id])
    redirect_to request.referer
  end

  def followings
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followings
  end

  def followers
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followers
  end
end
