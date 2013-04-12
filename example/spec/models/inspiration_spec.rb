require 'spec_helper'

describe Inspiration do
  it { should be_timestamped_document }
  it { should_have_a_valid_factory }

  it { should validate_presence_of :title }
  it { should validate_presence_of :resume }
  it { should validate_presence_of :description }
  it { should validate_presence_of :main_category }

  describe "highlight inspirations" do
    it "returns just highlighted" do
      expect(Inspiration.highlight.selector["highlight"]).to be_true
    end

    it "return first highlight" do
      inspiration = mock(Inspiration)
      Inspiration.stub_chain(:highlight, :limit, :first) { inspiration }

      expect(Inspiration.first_highlight).to eq(inspiration)
    end
  end
end