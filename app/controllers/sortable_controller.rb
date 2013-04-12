class SortableController < ApplicationController
  before_filter :authenticate_user!

  def update_order
    resources_ids  = params[:resources_ids] || []
    resource_class = params[:resource_class].to_s.classify.constantize

    resources_ids.each_with_index do |id, index|
      resource_class.update_priority(id, index + 1)
    end

    render json: {}, status: :ok
  end
end
