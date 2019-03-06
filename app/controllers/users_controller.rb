# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:name]

  def show
    @user = User.find(params[:id])
    @prots = @user.prots
                  .includes(:hearts)
                  .where.not(private: true)
                  .page(params[:page_1]).per(20)
    @reviews = @user.reviews
                    .includes(:goods)
                    .page(params[:page_2]).per(20)
  end

  def mypage
    @prots = current_user.prots
                         .includes(:hearts)
                         .page(params[:page_1]).per(20)
    @reviews = current_user.reviews
                           .includes(:goods)
                           .page(params[:page_2]).per(20)
  end

  def edit; end

  def update
    if current_user.update(user_params)
      bypass_sign_in(current_user)
      redirect_to mypage_path, notice: "プロフィールの編集に成功しました"
    else
      render :edit
    end
  end

  def name
    raise unless params[:query]

    result = nil
    if User.find_by(nick_name: params[:query])
        result = "findUser"
    else
        result = "notFind"
    end

    render :json => { :result => result }
    return true
  end

  private

  def user_params
    params.require(:user)
          .permit(:name,
                  :nick_name,
                  :profile,
                  :icon,
                  :password)
  end
end
