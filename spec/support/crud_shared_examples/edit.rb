shared_examples "CRUD GET edit" do |resource|
  let!(:factory){ create resource }

  describe "GET edit" do
    it "renders the form to update the resource" do
      get :edit, id: factory.to_param

      response.should render_template :edit
      assigns[resource].should == factory
    end
  end
end
