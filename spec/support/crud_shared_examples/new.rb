shared_examples "CRUD GET new" do |resource|
  let!(:factory){ create resource }

  describe "GET new" do
    it "renders the form to create a new resource" do
      get :new

      response.should render_template :new
      assigns[resource].should be_an_instance_of(factory.class)
    end
  end
end
