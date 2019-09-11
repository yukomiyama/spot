class TagsController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def show
    @user = User.find_by(id: params[:user_id])
    @tag_articles = @user.articles.where(tag_id: params[:id])
    @tag = Tag.find(params[:id])
    @tag_list = Tag.all
  end
end
