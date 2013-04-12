require 'spec_helper'

describe SortableController do
  describe "updating resource order" do
    login_user

    it "updates resources order" do
      creator1 = mock_model(Creator, id: "1")
      creator2 = mock_model(Creator, id: "2")

      Creator.should_receive(:update_priority).with(creator2.id, 1)
      Creator.should_receive(:update_priority).with(creator1.id, 2)

      put :update_order, resources_ids: [creator2.id, creator1.id], resource_class: "creator"
    end

    it "raises NameError if class does not exist" do
      expect {
        put :update_order, :resources_ids => [1, 2], :resource_class => "fake_model"
      }.to raise_error
    end
  end

end
