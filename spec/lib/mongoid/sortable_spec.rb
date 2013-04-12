require 'spec_helper'

describe Mongoid::Sortable do
  let!(:creator) { build(:creator) }

  it "includes a priority field" do
    fields = creator.fields.keys
    expect(fields).to include("priority")
  end

  describe "setting priority" do
    before do
      create(:creator)
    end

    it "sets the highest priority before create" do
      creator.save
      expect(creator.priority).to eq(2)
    end
  end

  describe "updating priority" do
    it "updates priority by id" do
      id       = 1
      priority = 10
      Creator.stub(:where).with(id: 1) { creator }
      creator.should_receive(:update).with(priority: priority)

      Creator.update_priority(id, priority)
    end
  end
end