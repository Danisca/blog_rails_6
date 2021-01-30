class ArticlesController < ApplicationController
	before_action :find_model, only: [:edit,:show,:update,:destroy]

	def index
		# @articles = Article.all
		# the commented lines are the way to use willpaginate Gem
		# perform a paginated query:
		# @posts = Post.paginate(page: params[:page])

		# or, use an explicit "per page" limit:
		@articles = Article.paginate(page: params[:page], per_page: 3)
	end

	def new
		@article = Article.new
		# byebug
	end

	def create
		@article = Article.new(articles_params)
		@article.user_id = 4
		# byebug
		if @article.save
			flash[:notice] = "Article was created succesfully"
			redirect_to @article
		else
			render "new"
		end
	end

	def update
		if @article.update(articles_params)
			flash[:notice] = "Article was updated succesfully"
			redirect_to @article
		else
			render "edit"
		end
	end

    def destroy
      @article.destroy
      redirect_to articles_path
    end

	private
	
	def find_model
		@article = Article.find(params[:id]) 
	end

	def articles_params
		params.require(:article).permit(:title,:description)
	end
end
