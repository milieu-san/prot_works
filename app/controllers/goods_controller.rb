# frozen_string_literal: true

class GoodsController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def create
    @good = current_user.goods.create(review_id: params[:review_id])
    @review = Review.find(params[:review_id])
    @review
  end

  def destroy
    @good = Good.find(params[:id])
    @good.destroy if @good.user == current_user
    @review = @good.review
    @review
  end
end
