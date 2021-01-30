class UsersController < ApplicationController
	before_action :find_user, only: [:edit,:show]

	def index
		# @users = User.all
		@users = User.paginate(page: params[:page], per_page: 3)
	end

	def show
		@articles = @user.articles.paginate(page: params[:page], per_page: 3)
		#line 6 could be made changing the _listing in partial the @article 
		#variable which wait for to a generic variable like the shared/errors partial
	end

	def new
		@user = User.new
		# puts("#{@user} PWD")
		# byebug
	end

	def create
		@user = User.new(set_user_fields)
		if @user.save
			flash[:notice] = "Welcome to the blog #{@user.username}, you have successfully signup"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @user = User.update(set_user_fields)
			flash[:notice] = "User updated successfully"
			redirect_to @user
		else
			render 'edit'
		end
	end


	private

		def set_user_fields
			params.require(:user).permit(:username,:email,:password)
		end

		def find_user
			@user = User.find(params[:id])
		end
end