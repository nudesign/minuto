class CategoriesController < ApplicationController
  def show
    resource  = Creator.by_category(params[:category_id])
    @creators = filtered_resource(resource).page(params[:page]).per(2)
    @page     = Page.find_for(:creators).first

    render 'creators/index'
  end
end
