class InspirationsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :by_tag]

  def index
    @highlight    = Inspiration.first_highlight
    @inspirations = Inspiration.list(user_signed_in?).without_highlight(@highlight)
    @page         = load_page

    begin
      @instagram_images = Instagram.user_recent_media(INSTAGRAM_USER_ID)
    rescue
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inspirations }
    end
  end

  def show
    @inspiration = Inspiration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inspiration }
    end
  end

  def new
    @inspiration = Inspiration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inspiration }
    end
  end

  def edit
    @inspiration = Inspiration.find(params[:id])
  end

  def create
    @inspiration = Inspiration.new(params[:inspiration])
    @inspiration.categories = params[:categories] if params[:categories]

    respond_to do |format|
      if @inspiration.save
        format.html { redirect_to edit_inspiration_path(@inspiration), notice: 'Inspiration was successfully created.' }
        format.json { render json: @inspiration, status: :created, location: @inspiration }
      else
        format.html { render "new" }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @inspiration = Inspiration.find(params[:id])
    @inspiration.categories = params[:categories] || []

    respond_to do |format|
      if @inspiration.update_attributes(params[:inspiration])
        format.html { redirect_to inspirations_path, notice: 'Inspiration was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render "edit" }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inspiration = Inspiration.find(params[:id])
    @inspiration.destroy

    respond_to do |format|
      format.html { redirect_to inspirations_url }
      format.json { head :ok }
    end
  end

  # TODO filtro por tags, categorias e busca de texto
  # poderia ser na mesma action
  def by_tag
    @inspirations = Inspiration.published.tagged_with(params[:query])
    @page         = load_page

    respond_to do |format|
      format.html { render "index" }
    end
  end

  private
    def load_page
      Page.find_for(:inspirations).first
    end
end