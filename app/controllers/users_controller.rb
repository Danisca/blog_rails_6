class UsersController < ApplicationController
	def new
		@user = User.new
		# puts("#{@user} PWD")
		# byebug
	end

	def create
		@user = User.new(set_user_fields)
		if @user.save
			flash[:notice] = "Welcome to the blog #{@user.username}, you have successfully signup"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	private

		def set_user_fields
			params.require(:user).permit(:username,:email,:password)
		end
end