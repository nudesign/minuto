shared_examples "CRUD POST create" do |resource|
  def resource_class(resource)
    resource.to_s.camelcase.constantize
  end

  def edit_path(resource)
    send(
      "edit_#{resource.to_s}_path",
      resource_class(resource).last
    )
  end

  describe "POST" do
    context "with valid data" do
      it "successfully creates a new resource" do
        post :create, { resource => attributes_for(resource) }

        response.should redirect_to edit_path(resource)
        flash[:notice].should == "#{resource_class(resource)} was successfully created."
      end
    end

    context "with invalid data" do
      before do
        resource_class(resource).any_instance.stub(:save).and_return(false)
      end

      it "fails to create a new resource" do
        post :create, { resource => {} }

        response.should render_template :new
        flash[:notice].should be_nil
      end
    end
  end
end
