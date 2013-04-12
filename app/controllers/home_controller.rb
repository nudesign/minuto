class HomeController < ApplicationController
  before_filter :load_page_informations

  def index
    @creators = Kaminari.paginate_array(Creator.newest).page(params[:page]).per(12)
    @inspirations = Inspiration.published.limit(2)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @creators }
      format.js
    end
  end

  private

  def load_page_informations
    @creator_page = Page.find_for(:creators).first
    @inspiration_page = Page.find_for(:inspirations).first
  end
end
