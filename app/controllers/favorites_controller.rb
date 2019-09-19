class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @article = Article.find(params[:article_id])
    @article.favorite(current_user)
  end

  def destroy
    @article = Favorite.find(params[:id]).article
    @article.remove_favorite(current_user)
  end
end
