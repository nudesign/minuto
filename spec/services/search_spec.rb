require "spec_helper"

describe Search do
  describe "filtering" do
    it "filters" do
      creator = mock_model(Creator, name: "jobs")
      criteria = Creator.criteria
      criteria.stub(:search).with(creator.name) { [creator] }
      result = Search.new(criteria).filter(creator.name)

      expect(result).to eq([creator])
    end
  end
end