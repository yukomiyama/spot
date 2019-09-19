class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :show, :index, :following, :followers]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      flash[:success] = "Welcome to the spot"
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Edit success"
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
    # @articles = Article.includes(:user).where(articles: {user_id: @user.id})
    @articles = Article.where(user_id: @user.id)
    @tags = Tag.all
  end

  def index
    @users = User.all
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :myspot_name, :img, :remove_img)
    end
end
