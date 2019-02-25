# frozen_string_literal: true

class HeartsController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def create
    @heart = current_user.hearts.create(prot_id: params[:prot_id])
    @prot = Prot.find(params[:prot_id])
    @prot
  end

  def destroy
    @heart = Heart.find(params[:id])
    @heart.destroy if @heart.user == current_user
    @prot = @heart.prot
    @prot
  end
end
