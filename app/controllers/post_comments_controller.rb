class PostCommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @record = Record.find(params[:record_id])
    comment = current_end_user.post_comments.new(post_comment_params)
    comment.record_id = @record.id
    comment.save
    @post_comments = PostComment.where(record_id: @record.id)
  end

  def destroy
    PostComment.find_by(id: params[:id]).destroy
    @record = Record.find(params[:record_id])
    @post_comments = PostComment.where(record_id: @record.id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
