class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def load_creator
    if user_signed_in?
      @creator = Creator.find(params[:creator_id] || params[:id])
    else
      load_creator_or_redirect
    end
  end

  def load_creator_or_redirect
    if session[:creator_id]
      @creator = Creator.find(session[:creator_id])
    else
      redirect_to new_user_session_path
    end
  end

  def filtered_resource(resource_list)
    if user_signed_in?
      resource_list
    else
      resource_list.published
    end
  end
end
