shared_examples "CRUD GET show" do |resource|
  let!(:factory){ create resource }

  describe "GET show" do
    it "show a specific resource" do
      get :show, id: factory.to_param

      response.should render_template :show
      assigns[resource].should == factory
    end
  end
end
