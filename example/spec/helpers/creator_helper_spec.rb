# encoding: utf-8

require 'spec_helper'

describe CreatorHelper do
  describe '#creator_preview_data' do
    let(:creator) { create :creator }

    context 'without avatar' do
      subject { helper.creator_preview_data(creator) }

      it { should have_json_path 'name' }
      it { should have_json_path 'location' }
      it { should have_json_path 'occupation' }
      it { should have_json_path 'release' }
      it { should have_json_path 'interview' }
      it { should have_json_path 'categories' }
    end

    context 'with avatar' do
      before { creator.stub_chain(:avatar, :thumb, :url).and_return("/path/to/image.jpg") }
      subject { helper.creator_preview_data(creator) }

      it { should have_json_path 'name' }
      it { should have_json_path 'location' }
      it { should have_json_path 'occupation' }
      it { should have_json_path 'release' }
      it { should have_json_path 'interview' }
      it { should have_json_path 'categories' }
      it { should have_json_path 'avatar' }
    end
  end

  describe '#filtered_category' do
    context 'a category is selected' do
      let(:category_name) { "art" }

      it 'show category name' do
        helper.filtered_category(category_name).should eq(t("category.#{category_name}"))
      end
    end

    context 'without a selected category' do
      it 'show field label' do
        helper.filtered_category(nil).should eq('selecionar área')
      end
    end
  end

  describe '#search_placeholder' do
    context 'a value is sought' do
      let(:value) { "design" }

      it 'show the value as placeholder' do
        helper.search_placeholder(value).should eq(value)
      end
    end

    context 'without a value' do
      it 'show default placeholder' do
        helper.search_placeholder(nil).should eq('busca')
      end
    end
  end
end
