class RecordsController < ApplicationController
  def index
    @records = Record.all
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    @record.save ? (redirect_to mypage_path(current_end_user.id)) : (render :new)
  end

  def show
    @record = Record.find(params[:id])
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    record = Record.find(params[:id])
    record.update(record_params) ? (redirect_to record_path(record.id)) : (render :edit)
  end

  def destroy
    record = Record.find(params[:id])
    record.destroy
    redirect_to mypage_path(current_end_user.id)
  end

  private

  def record_params
    params.require(:record).permit(:title, :image, :artist_name, :genre, :introduction, :release_date, :end_user_id)
  end
end

