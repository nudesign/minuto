shared_examples "NESTED CRUD GET destroy embeds many" do |resource, parent|

  def default_hash(parent)
    { "#{parent}_id" => parent_factory.to_param }
  end

  def default_hash_with_id(parent)
    default_hash(parent).merge(id: factory.to_param)
  end

  def edit_parent_path(parent)
    send(
      "edit_#{parent.to_s}_path",
      parent_factory.class.last,
    )
  end

  let!(:parent_factory){ create parent }
  let!(:factory){ create resource, parent => parent_factory }

  describe "DELETE" do

    it {
      expect { get :destroy, default_hash_with_id(parent) }.to change {
        parent_factory.reload.products.size
      }.by(-1)
    }

    it "redirect after delete" do
      get :destroy, default_hash_with_id(parent)
      response.should redirect_to edit_parent_path(parent)
    end

  end
end
