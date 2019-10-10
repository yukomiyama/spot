class CommunitiesController < ApplicationController
  before_action :logged_in_user

  def new
    @community = Community.new
  end

  def create
    @community = current_user.communities.new(community_params)
    if @community.save
      redirect_to community_path(@community.id)
    else
      render :new
    end
  end

  def edit
    @community = @community = Community.find(params[:id])
  end

  def update
    @community = Community.find(params[:id])
    if @community.update_attributes(community_params)
      redirect_to community_path(@community.id)
    else
      render :edit
    end
  end

  def destroy
    @community = Community.find(params[:id])
    @community.destroy
    redirect_to communities_path
  end

  def show
    @community = Community.find(params[:id])

    #user_communityテーブルにあるuser_idを配列で取得
    community_joined_user_id_array = @community.join_users.map {|user| user.id }
    #Articleテーブルからcommunityに登録のあるユーザーの記事を取得
    @articles = Article.includes(:user).where(user_id: community_joined_user_id_array).order('created_at desc')
  end

  def index
    @communities = Community.includes(:user)
  end

  private

    def community_params
      params.require(:community).permit(:name, :explanation)
    end
end
