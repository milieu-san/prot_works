class StarsController < ApplicationController
  before_action :authenticate_user!
  def create
    Star.create(give_user_id: current_user.id, take_user_id: params[:take_user_id])
    redirect_to user_path(params[:take_user_id])
  end

  def destroy
    @star = Star.find_by(give_user_id: current_user.id, take_user_id: params[:take_user_id] )
    @star.destroy
    redirect_to user_path(params[:take_user_id])
  end
end
