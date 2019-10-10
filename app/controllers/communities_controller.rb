class CommunitiesController < ApplicationController
  def new
    @community = Community.new
  end

  def create
    @community = current_user.communities.new(community_params)
    if @community.save
      redirect_to communities_path
    else
      render :new
    end
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
