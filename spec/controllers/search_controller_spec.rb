require 'spec_helper'

describe SearchController do
  describe "GET 'index'" do
    let(:creators){ [mock] }

    before do
      Creator.should_receive(:search).with('word').and_return(creators)
      creators.should_receive(:published).and_return(creators)
    end

    xit "returns http success" do
      get :show, query: 'word'

      response.should be_success
      assigns[:creators].should == creators
    end
  end

  context 'admin' do
    login_user

    describe "GET 'index'" do
      let(:creators){ [mock] }

      before do
        Creator.should_receive(:search).with('word').and_return(creators)
        creators.should_not_receive(:published)
      end

      xit "returns http success" do
        get :show, query: 'word'

        response.should be_success
        assigns[:creators].should == creators
      end
    end
  end
end
