require 'spec_helper'

describe PageHelper do
  describe '#edit_or_create_page_for' do
    let(:type) { :creators }

    context 'without page' do
      subject { helper.edit_or_create_page_for(type) }

      it { should == new_page_path(type) }
    end

    context 'with page' do
      before { create :page, type: type }
      subject { helper.edit_or_create_page_for(type) }

      it { should == edit_page_path(type) }
    end
  end
end
