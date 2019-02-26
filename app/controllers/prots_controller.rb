# frozen_string_literal: true

class ProtsController < ApplicationController
  before_action :set_prot, only: %i[show edit update destroy children]
  before_action :authenticate_user!, except: %i[index]
  before_action :correct_user_check, only: %i[edit update destroy]
  before_action :private_prot_protect, only: %i[show edit update destroy]

  def index
    @prots = Prot.limit(20)
                 .where(private: false)
                 .includes_all
                 .includes(:hearts).sort_by { |prot| -prot.hearts.length }
  end

  def show; end

  def search
    @prots = if params[:prot]
               Prot.where(private: false)
                   .includes_all
                   .search_order(params[:prot])
                   .page(params[:page]).per(50)
             else
               Prot.where(private: false)
                   .includes_all
                   .page(params[:page]).per(50)
             end
    @form_default = params[:prot]
  end

  def new
    @prot = Prot.new
    set_prot_builds
  end

  def create
    @prot = current_user.prots.new(prot_params)
    if @prot.save
      # 要トランザクション
      @prot.nodes.create(title: @prot.title.to_s, body: '本文', position: 0)
      redirect_to @prot
      flash[:success] = 'プロットの作成に成功しました'
    else
      render :new
      set_prot_builds
    end
  end

  def edit
    set_prot_builds
  end

  def update
    if @prot.update(prot_params)
      redirect_to @prot
      flash[:success] = 'プロットの編集に成功しました'
    else
      render :edit
      set_prot_builds
    end
  end

  def destroy
    @prot.destroy
    flash[:success] = 'プロットの削除に成功しました'
    redirect_to root_path
  end

  private

  def prot_params
    params.require(:prot)
          .permit(:title,
                  :content,
                  :private,
                  :accepts_review,
                  genres_attributes: %i[id name],
                  media_types_attributes: %i[id name])
  end

  def correct_user_check
    raise StandardError if @prot.user_id != current_user.id
  end

  def private_prot_protect
    raise StandardError if @prot.private == true && @prot.user_id != current_user.id
  end

  def set_prot
    @prot = Prot.find(params[:id])
  end

  def set_prot_builds
    @prot.genres.build if @prot.genres.blank?
    @prot.media_types.build if @prot.media_types.blank?
  end
end
