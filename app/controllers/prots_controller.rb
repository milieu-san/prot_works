class ProtsController < ApplicationController
  before_action :set_prot, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index]

  def index
    @prots = Prot.all
  end

  def show
  end

  def new
    @prot = Prot.new
  end

  def create
    @prot = current_user.prots.new(prot_params)
    if @prot.save
      redirect_to @prot
      flash[:success] = "プロットの作成に成功しました"
    else
      render :new
    end
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
    @prot = Prot.find(params[:id])
  end
end
