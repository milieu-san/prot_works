class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def mypage
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
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
                  :profile)
  end
end
