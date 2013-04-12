shared_examples "NESTED CRUD GET show" do |resource, parent|
  def default_hash(parent)
    { "#{parent}_id" => parent_factory.to_param }
  end

  def default_hash_with_id(parent)
    default_hash(parent).merge(id: factory.to_param)
  end

  let!(:parent_factory){ create parent }
  let(:factory){ create resource, parent => parent_factory }

  describe "GET show" do
    it "show a specific resource" do
      get :show, default_hash_with_id(parent)

      response.should render_template :show
      assigns[resource].should == factory
    end
  end
end
