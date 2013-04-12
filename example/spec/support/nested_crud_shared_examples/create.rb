shared_examples "NESTED CRUD POST create" do |resource, parent|
  def post_hash(parent, resource, valid=true)
    {
      "#{parent}_id" => parent_factory.to_param,
      resource => valid ? attributes_for(resource) : {}
    }
  end

  def invalid_post_hash(parent, resource)
    post_hash(parent, resource, false)
  end

  def edit_path(parent, resource)
    _factory = factory.is_a?(Gallery) ? factory.class.last : factory

    send(
      "edit_#{parent.to_s}_#{resource.to_s}_path",
      parent_factory.class.last,
      _factory
    )
  end

  let!(:parent_factory){ create parent }
  let(:factory){ create resource, parent => parent_factory }

  describe "POST" do
    context "with valid data" do
      it "successfully creates a new resource" do
        post :create, post_hash(parent, resource)

        response.should redirect_to edit_path(parent, resource)
        flash[:notice].should == I18n.t('flash.actions.create.notice', resource_name: factory.class.model_name.human)
      end
    end

    context "with invalid data" do
      it "fails to create a new resource" do
        post :create, invalid_post_hash(parent, resource)

        response.should render_template :new
        flash[:notice].should be_nil
      end
    end
  end
end
