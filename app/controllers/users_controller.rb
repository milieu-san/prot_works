class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @prots = @user.prots
                  .includes(:hearts)
                  .where.not(private: true)
                  .page(params[:page]).per(20)
    @reviews = @user.reviews
                    .includes(:goods)
                    .page(params[:page]).per(20)
  end

  def mypage
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      sign_in(current_user, bypass: true)
      redirect_to mypage_path
    else
      render :edit
    end
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
