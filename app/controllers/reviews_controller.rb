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
  end

  def edit
  end

  def update
  end

  def destroy
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
