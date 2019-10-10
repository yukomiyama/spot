class UserCommunitiesController < ApplicationController
  before_action :logged_in_user

  def create
    @user_community = current_user.user_communities.create(community_id: params[:community_id])
  end

  def destroy
    @user_community = current_user.user_communities.find(params[:id])
    @user_community.destroy
  end
end
