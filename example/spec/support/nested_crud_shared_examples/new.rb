shared_examples "NESTED CRUD GET new" do |resource, parent|
  def default_hash(parent)
    { "#{parent}_id" => parent_factory.to_param }
  end

  let!(:factory){ create resource }
  let!(:parent_factory){ create parent }

  describe "GET new" do
    it "renders the form to create a new resource" do
      get :new, default_hash(parent)

      response.should render_template :new
      assigns[resource].should be_an_instance_of(factory.class)
    end
  end
end
