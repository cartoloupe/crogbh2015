class CategoriesController < ApplicationController
  def index
  end

  def show
    @category = Category.find params[:id]
    @services = @category.services
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit :name
  end
end

