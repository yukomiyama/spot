class TagsController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.where(user_id: params[:user_id])
  end

end
