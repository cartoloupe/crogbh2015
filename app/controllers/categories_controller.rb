class CategoriesController < ApplicationController
  def new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  private

  def category_params
    params.permit :name
  end
end

