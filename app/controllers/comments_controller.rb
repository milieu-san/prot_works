class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to prot_review_path(@comment.review.prot_id, @comment.review_id)
      flash[:success] = "コメントを投稿しました"
    else
      redirect_to prot_review_path(Review.find(@comment.review_id).prot_id, @comment.review_id)
      flash[:danger] = "コメントを投稿できませんでした"
    end
  end

  private

  def comment_params
    params.require(:comment)
          .permit(:body,
                  :review_id)
  end
end
