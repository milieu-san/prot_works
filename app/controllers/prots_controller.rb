class ProtsController < ApplicationController
  before_action :set_prot, only: %i[show edit update destroy]

  def index
    @prots = Prot.all
  end

  def show
  end

  def new
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
