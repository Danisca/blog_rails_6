class UsersController < ApplicationController
	before_action :find_user, only: [:edit,:show,:update,:destroy]
        before_action :require_user, except: [:index,:show,:new,:create]
        before_action :require_owner, only: [:edit,:update,:destroy]

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
                        session[:user_id] = @user.id
			flash[:notice] = "Welcome to the blog #{@user.username}, you have successfully signup"
                        redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @user.update(set_user_fields)
			flash[:notice] = "User updated successfully"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
          @user.destroy
          session[:user_id] = nil
          flash[:notice] = "Account successfully deleted and its articles"
          redirect_to root_path
	end


	private

	  def set_user_fields
	    params.require(:user).permit(:username,:email,:password)
	  end

	def find_user
          @user = User.find(params[:id])
	end

	def require_owner 
          #this method checks if the user is the owner of the profile, and if it is then permit the :edit,:update,:destroy
            if current_user != @user
              flash[:error] = "you can only edit or delete your own profile"
              redirect_to @user
            end
	end
end
