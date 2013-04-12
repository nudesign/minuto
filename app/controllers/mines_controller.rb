class MinesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  respond_to :html

  def index
    @highlight  = Mine.newest.first
    @mines      = Mine.newest.where(:id.ne => @highlight.id) if @highlight
    @page       = load_page
  end

  def show
    @mine = Mine.find(params[:id])
  end

  def new
    @mine = Mine.new
  end

  def create
    @mine = Mine.new(params[:mine])

    respond_to do |format|
      if @mine.save
        format.html { redirect_to edit_mine_path(@mine), notice: "Mine was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @mine = Mine.find(params[:id])
  end

  def update
    @mine = Mine.find(params[:id])

    respond_to do |format|
      if @mine.update_attributes(params[:mine])
        format.html { redirect_to mines_path, notice: "Mine was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def load_page
      Page.find_for(:mines).first
    end

end
