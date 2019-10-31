class ArticlesController < ApplicationController
  before_action :logged_in_user

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)

    # respond_to do |format|
    #   if @post.save
    #     format.html { redirect_to user_path(current_user.id), notice: 'Post was successfully created.' }
    #     format.json { render :show, status: :created, location: @article }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @article.errors, status: :unprocessable_entity }
    #   end
    # end

    #画像リサイズ
    # if params[:imgs] != nil
    #   imgs = MiniMagick::Image.read(params[:imgs])
    #   img.resize "300x300"
    #   img.write "public/images/sample.jpg"
    # end
    # @article.imgs = imgs

    if @article.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect_to user_path(current_user.id)
  end

  def show
    @article = Article.find(params[:id])
    @tag = Tag.find(@article.tag_id)
    @comment = Comment.new
    @comments = Comment.where(article_id: @article.id).includes(:user)
  end

  def index
    @articles = Article.search(params[:search]).includes(:user)
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :tag_id, imgs: [])
    end
end
