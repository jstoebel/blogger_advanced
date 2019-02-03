class ArticlesController < ApplicationController
  def show
    respond_to do |format|
      format.html
      # TODO: add a jbuilder and remove this method
      format.json { render json: article }
    end
  end

  def article
    @cached_article ||= Article.find_or_initialize_decorated(id: params[:id])
  end
  helper_method :article

  def index
    articles, @tag = Article.search_by_tag_name(params[:tag])
    @articles = ArticleDecorator.decorate_collection articles

    respond_to do |format|
      format.html
      format.json { render json: @articles }
    end
  end

  def create
    a = article
    a.assign_attributes(article_params)
    if a.save
      flash[:notice] = 'Article was created.'
      redirect_to articles_path
    else
      render :new
    end
  end

  def update
    if article.update_attributes(article_params)
      flash[:notice] = 'Article was updated.'
      redirect_to article_path(article)
    else
      render :edit
    end
  end

  def destroy
    a = article
    a.destroy
    flash[:notice] = "#{article} was destroyed."
    redirect_to articles_path
  end
  
  private

  def article_params
    params.require(:article).permit(:title, :body, :author_id)
  end
  
end
