class SearchController < ApplicationController
  # TODO extract to corresponding model controllers
  def index
    resource        = params[:resource]
    plural_resource = resource.pluralize
    model           = resource.capitalize.constantize

    resources = Search.new(model.list(user_signed_in?)).filter(params[:query])
    instance_variable_set("@#{plural_resource}", resources)
    @page      = Page.find_for(plural_resource.to_sym).first

    render "#{plural_resource}/index"
  end
end
