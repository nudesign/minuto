shared_examples "NESTED CRUD PUT update" do |resource, parent|
  def invalid_attributes_for(resource)
    attributes_for(resource).keys.inject({}) do |hash, key|
      hash[key] = nil
      hash
    end
  end

  def put_hash(parent, resource, valid=true)
     {
       "#{parent}_id" => parent_factory.to_param,
       id: factory.to_param,
       resource => valid ? attributes_for(resource) : invalid_attributes_for(resource)
     }
  end

  def invalid_put_hash(parent, resource)
    put_hash(parent, resource, false)
  end

  def parent_path(parent)
    send(
      "edit_#{parent.to_s}_path",
      parent_factory.class.last,
    )
  end

  let!(:parent_factory){ create parent }
  let(:factory){ create resource, parent => parent_factory }

  describe "PUT" do
    context "with valid data" do
      it "successfully updates a resource" do
        put :update, put_hash(parent, resource)

        response.should redirect_to parent_path(parent)
        flash[:notice].should ==  I18n.t('flash.actions.update.notice', resource_name: factory.class.model_name.human)
      end
    end

    context "with invalid data" do
      it "fails to update a resource" do
        put :update, invalid_put_hash(parent, resource)

        response.should render_template :edit
        flash[:notice].should be_nil
      end
    end
  end
end
