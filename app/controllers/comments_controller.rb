class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = params[:article_id]
    if @comment.save
      redirect_to article_path(@comment.article_id)
    else
      render "articles/show"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
