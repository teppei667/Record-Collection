class RoomsController < ApplicationController

  def index
    @end_user = current_end_user
    @currentEntries = @end_user.entries
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: myRoomIds).where.not(end_user_id: @end_user.id).order(created_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(:end_user_id => current_end_user.id, :room_id => @room.id).present?
      @direct_messages = @room.direct_messages
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
