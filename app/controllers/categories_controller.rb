class CategoriesController < ApplicationController
  before_action :set_category, only: [:show,:edit, :update]
  before_action :require_user, except: [:index,:show]
  before_action :only_admins, except: [:show, :index]

  def index 
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    #byebug
    if @category.save
      flash[:notice] = "Category successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 3) if @category.articles.any?
  end

  def edit 
  end
  def update 
    if @category.update(category_params)
      flash[:notice] = "Category successfully updated"
      redirect_to @category
    else
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def only_admins
    if !logged_in? || ( logged_in? and current_user.user_role != "admin")
        flash[:error] = "only admins can perform that action"
        redirect_to categories_path 
    end
  end
end

