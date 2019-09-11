class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = params[:user_id]
    @comment.article_id = params[:article_id]
    if @comment.save
      redirect_to user_article_path(@comment.user_id, @comment.article_id)
    else
      render "articles/show"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
