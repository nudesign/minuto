require "spec_helper"

describe ApplicationHelper do
  describe "sortable lists" do
    context "when is sortable" do
      it "should return css class 'list-sortable'" do
        expect(is_sortable?(true)).to eq("list-sortable")
      end
    end

    context "when is not sortable" do
      it "should return nil" do
        expect(is_sortable?(false)).to be_nil
      end
    end
  end
end