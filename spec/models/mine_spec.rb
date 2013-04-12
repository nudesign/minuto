require 'spec_helper'

describe Mine do
  it { should validate_presence_of :title }
  it { should respond_to(:resume) }
  it { should respond_to(:products) }
  it { should be_timestamped_document }

  it "ordering by desc" do
    Mine.newest.criteria.should == Mine.order_by(created_at: :desc).criteria
  end
end
