class PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_page, only: [:edit, :update, :destroy]

  def new
    @page = Page.new(type: params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  def edit
  end

  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to edit_page_path(@page), notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to polymorphic_path(params[:id]), notice: 'Page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to polymorphic_path(params[:id]), notice: 'Page was successfully deleted.' }
      format.json { head :ok }
    end
  end

  private

  def load_page
    @page = Page.find(params[:id])
  end
end
