shared_examples "CRUD GET index" do |resource|
  let!(:factory){ create resource }

  describe "GET index" do
    it "display a list of resources" do
      get :index

      response.should render_template :index
      assigns[resource.to_s.pluralize.to_sym].should == [factory]
    end
  end
end
