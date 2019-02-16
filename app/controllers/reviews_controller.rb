class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
    @review = current_user.reviews.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to prot_review_path(@review.prot_id, @review.id)
      flash[:success] = "レビューの投稿に成功しました！"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to prot_review_path(@review.prot_id, @review.id)
      flash[:success] = "レビューの編集に成功しました！"
    else
      render :edit
    end

  end

  def destroy
    @review.destroy
    flash[:success] = "レビューの削除に成功しました！"
    redirect_to prot_path(@review.prot_id)
  end

  private

  def review_params
    params.require(:review)
          .permit(:title,
                  :content,
                  :user_id,
                  :prot_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
