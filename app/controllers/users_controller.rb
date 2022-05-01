class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
    puts @user.access_token_of_line_notify
    return @user
  end

  def create
    puts user_params[:access_token_of_line_notify]
    @user = User.new(user_params)
    puts @user.access_token_of_line_notify
    if @user.save
      log_in @user
      flash[:success] = "ユーザ登録が完了しました"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザ情報の編集が完了しました"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :access_token_of_line_notify)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインをしてください"
        store_location
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
