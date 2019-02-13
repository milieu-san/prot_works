class User::ProtsController < ApplicationController
  before_action :authenticate_user!

  def index
    @prots = current_user.prots.all
  end

  def show
  end

  def edit
  end

  def update
    if @prot.update(prot_params)
      redirect_to @prot
      flash[:success] = "プロットの編集に成功しました"
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def prot_params
  params.require(:prot)
        .permit(:title,
                :content,
                :private,
                :accepts_review)
  end

  def set_prot
    @prot = current_user.prots.find(params[:id])
  end
end
