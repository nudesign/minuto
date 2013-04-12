shared_examples "CRUD GET destroy" do |resource, resource_redirect|
  def resource_path(resource)
    send("#{resource.to_s.pluralize}_path")
  end

  let!(:factory){ create resource }

  describe "DELETE" do
    it { expect { get :destroy, id: factory.to_param }.to change {factory.class.count}.by(-1) }

    it "redirect after delete" do
      get :destroy, id: factory.to_param
      response.should redirect_to resource_path(resource_redirect || resource)
    end
  end
end
