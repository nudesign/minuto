require 'spec_helper'

describe InspirationHelper do
  describe "#tag_list" do
    context 'one inspiration' do
      before do
        create :inspiration, tag_list: "rocky, balboa"
      end

      it { helper.tag_list.should == ["balboa", "rocky"] }
    end

    context 'more than one inspiration' do
      before do
        create :inspiration, tag_list: "rocky, balboa"
        create :inspiration, tag_list: "rocky, apollo, creed"
        create :inspiration, tag_list: "drago"
      end

      it { helper.tag_list.should == ["apollo", "balboa", "creed", "drago", "rocky"] }
    end

    context 'with unpublished inspiration' do
      before do
        create :inspiration, tag_list: "rocky, balboa"
        create :draft_inspiration, tag_list: "drago"
      end

      it { helper.tag_list.should == ["balboa", "rocky"] }
    end
  end
end
