class ProductsController < ApplicationController
  respond_to :html

  before_filter :load_mine

  def new
    @product = Product.new
  end

  def create
    @product = @mine.products.new(params[:product])
    @product.categories = params[:categories] if params[:categories]

    respond_to do |format|
      if @product.save
        format.html { redirect_to edit_mine_product_path(@mine, @product), notice: t('flash.actions.create.notice', resource_name: Product.model_name.human) }
      else
        format.html { render "new" }
      end
    end
  end

  def edit
    @product = @mine.products.find(params[:id])
  end

  def update
    @product = get_product(params[:id])
    @product.categories = params[:categories] if params[:categories]

    if @product.update_attributes(params[:product])
      flash[:notice] = t('flash.actions.update.notice', resource_name: Product.model_name.human)
    end

    respond_with(@product, location: edit_mine_path(@mine))
  end

  def destroy
    @product = get_product(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to edit_mine_path(@mine), notice: t('flash.actions.destroy.notice', resource_name: Product.model_name.human) }
    end
  end

  private

    def load_mine
      @mine = Mine.find(params[:mine_id]) if params[:mine_id]
    end

    def get_product(id)
      @mine.products.find(id)
    end

end
