class PostCommentsController < ApplicationController

  def create
    record = Record.find(params[:record_id])
    comment = PostComment.new(post_comment_params)
    comment.end_user_id = current_end_user.id
    comment.record_id = record.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    PostComment.find_by(id: params[:id]).destroy
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
