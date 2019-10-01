class CommunitiesController < ApplicationController
  def new
    @community = Community.new
  end

  def create
    @community = current_user.communities.new(community_params)
    if @community.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def index

  end

  private

    def community_params
      params.require(community).permit(:name)
    end
end
