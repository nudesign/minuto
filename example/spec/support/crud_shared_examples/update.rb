shared_examples "CRUD PUT update" do |resource, resource_redirect|
  def invalid_attributes_for(resource)
    attributes_for(resource).keys.inject({}) do |hash, key|
      hash[key] = nil
      hash
    end
  end

  def resource_path(resource)
    send("#{resource.to_s.pluralize}_path")
  end

  let!(:factory){ create resource }

  describe "PUT" do
    context "with valid data" do
      it "successfully updates a resource" do
        put :update, { id: factory.to_param, resource => attributes_for(resource) }

        response.should redirect_to resource_path(resource_redirect || resource)
        flash[:notice].should == "#{factory.class} was successfully updated."
      end
    end

    context "with invalid data" do
      it "fails to update a resource" do
        put :update, { id: factory.to_param, resource => invalid_attributes_for(resource) }

        response.should render_template :edit
        flash[:notice].should be_nil
      end
    end
  end
end
