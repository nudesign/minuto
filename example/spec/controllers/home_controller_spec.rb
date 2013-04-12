require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    let!(:page){ create :page }
    let(:creators){ [mock] }

    before do
      Creator.should_receive(:newest).and_return(creators)
      creators.stub_chain(:page, :per).and_return(creators)

      Page.should_receive(:find_for).with(:creators).and_return([])
      Page.should_receive(:find_for).with(:inspirations).and_return([])
    end

    it "returns http success" do
      get :index

      response.should be_success
      assigns[:creators].should == creators
    end
  end
end
