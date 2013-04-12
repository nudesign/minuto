class GalleriesController < ApplicationController
  before_filter :authenticate_user!, only: [:destroy]

  before_filter :load_creator
  before_filter :load_gallery, only: [:show, :edit, :update, :destroy]
  before_filter :has_gallery?, only: :new

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
      format.js
    end
  end

  def new
    @gallery = @creator.galleries.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end

  def edit
  end

  def create
    @gallery = @creator.galleries.new(params[:gallery])

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to edit_creator_gallery_path(@creator, @gallery), notice: t('flash.actions.create.notice', resource_name: Gallery.model_name.human) }
        format.json { render json: @gallery, status: :created, location: [@creator, @gallery] }
      else
        format.html { render "new" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        format.html { redirect_to edit_creator_path(@creator), notice: t('flash.actions.update.notice', resource_name: Gallery.model_name.human) }
        format.json { render json: @gallery, status: :ok }
      else
        format.html { render "edit" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to edit_creator_url(@creator), notice: t('flash.actions.destroy.notice', resource_name: Gallery.model_name.human) }
      format.json { head :ok }
    end
  end

  private

  def load_gallery
    @gallery = @creator.galleries.find(params[:id])
  end

  def has_gallery?
    if !user_signed_in? && !@creator.galleries.empty?
      redirect_to edit_creator_path(@creator)
    end
  end
end
