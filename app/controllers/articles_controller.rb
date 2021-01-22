class ArticlesController < ApplicationController
	before_action :find_model, only: [:edit,:show,:update,:destroy]

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(articles_params)
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
