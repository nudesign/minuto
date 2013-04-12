# encoding: UTF-8
class CreatorsController < ApplicationController
  before_filter :authenticate_user!, only: [:delete, :unapproved, :portfolios]
  before_filter :load_creator, only: [:edit, :update, :send_portfolio, :step2]

  def index
    @creators = filtered_creators.asc(:priority).page(params[:page]).per(18)
    @page = Page.find_for(:creators).first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @creators }
      format.js
    end
  end

  def portfolios
    @creators = Creator.portfolios
    render :index
  end

  def show
    @creator = Creator.find(params[:id])

    if !user_signed_in? && !@creator.published?
      redirect_to creators_path, notice: "O creator #{@creator.name} ainda não foi aprovado. Em breve esta página estará disponível."
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @creator }
    end
  end

  def new
    @creator = Creator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @creator }
    end
  end

  def edit
  end

  def create
    @creator = Creator.new(params[:creator])
    @creator.categories = params[:categories] if params[:categories]

    session[:creator_id] = @creator.id unless user_signed_in?

    respond_to do |format|
      if @creator.save
        format.html { redirect_to edit_creator_path(@creator), notice: 'Creator was successfully created.' }
        format.json { render json: @creator, status: :created, location: @creator }
      else
        format.html { render "new" }
        format.json { render json: @creator.errors, status: :unprocessable_entity }
      end
    end
  end

  def step2
    respond_to do |format|
      if @creator.second_step
        format.html { redirect_to edit_creator_path(@creator), notice: 'Creator criado com sucesso. Já é possível criar uma galeria.' }
        format.json { render json: @creator, status: :created, location: @creator }
      else
        format.html { render "edit" }
        format.json { render json: @creator.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @creator.categories = params[:categories] || []

    respond_to do |format|
      if @creator.update_attributes(params[:creator])
        format.html { redirect_to creators_path, notice: 'Creator was successfully updated.' }
        format.json { render json: @creator, status: :ok }
      else
        format.html { render "edit" }
        format.json { render json: @creator.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @creator = Creator.find(params[:id])
    @creator.destroy

    respond_to do |format|
      format.html { redirect_to creators_url }
      format.json { head :ok }
    end
  end

  def send_portfolio
    session.delete(:creator_id)
    redirect_to creators_path, notice: 'Seu portfolio foi enviado com sucesso.'
  end

  private

  def filtered_creators
    user_signed_in? ? Creator.approved : Creator.published
  end
end
