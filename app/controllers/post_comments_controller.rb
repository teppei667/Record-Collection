class PostCommentsController < ApplicationController

  def create
    @record = Record.find(params[:record_id])
    comment = PostComment.new(post_comment_params)
    comment.end_user_id = current_end_user.id
    comment.record_id = @record.id
    comment.save
    @post_comments = PostComment.where(record_id: @record.id).order(created_at: :desc)

  end

  def destroy
    PostComment.find_by(id: params[:id]).destroy
    @record = Record.find(params[:record_id])
    @post_comments = PostComment.where(record_id: @record.id).order(created_at: :desc)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
