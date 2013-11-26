class CategoriesController < ApplicationController
  before_action :current_resource, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.sorted
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'The category was created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to categories_path, notice: 'The category was updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: 'The category was deleted.'
  end

  private

    def current_resource
      @category = Category.find(params[:id]) if params[:id]
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
