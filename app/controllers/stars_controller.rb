# frozen_string_literal: true

class StarsController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def create
    @star = Star.create(give_user_id: current_user.id, take_user_id: params[:take_user_id])
    @user = User.find(params[:take_user_id])
    @user
  end

  def destroy
    @star = Star.find(params[:id])
    @star.destroy if @star.give_user_id == current_user.id
    @user = User.find(@star.take_user_id)
    @user
  end
end
