class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    # @books = @user.books
    @book = Book.new
    @books = Book.where(user_id: @user.id)
  end

  def index
    @users = User.all
    @book = Book.new
  # 2.endがない
  end

  def edit
    @user = User.find(params[:id])
    # 他ユーザーのページの場合自分のページに移動
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  #フォローする
  def follow
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  #フォローを外す
  def unfollow
      @user = User.find(params[:user_id])
      current_user.stop_following(@user)
      redirect_to user_path(@user)
  end

  #フォローしてる人の一覧ページ
  def follow_list
    @user = User.find(params[:user_id])
  end

  #フォロワーの一覧ページ
  def follower_list
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end