class RoomsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @end_user = current_end_user
    @current_entries = @end_user.entries.includes([:room])
    my_room_ids = []
    @current_entries.each do |entry|
      my_room_ids << entry.room.id
    end
    @another_entries = Entry.where(room_id: my_room_ids).where.not(end_user_id: @end_user.id).order(created_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(:end_user_id => current_end_user.id, :room_id => @room.id).present?
      @direct_messages = @room.direct_messages.includes([:end_user])
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create(:name => "DM")
    @entry1 = Entry.create(:room_id => @room.id, :end_user_id => current_end_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:end_user_id, :room_id).merge(:room_id => @room.id))
    redirect_to room_path(@room.id)
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to request.referer
  end
end
