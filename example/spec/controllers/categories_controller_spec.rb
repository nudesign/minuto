require 'spec_helper'

describe CategoriesController do
  describe "GET 'index'" do
    let!(:page){ create :page }
    let(:creators){ [mock] }

    before do
      Creator.should_receive(:by_category).with('art').and_return(creators)
      creators.should_receive(:published).and_return(creators)
      creators.stub_chain(:page, :per).and_return(creators)
    end

    xit "returns http success" do
      get :show, category_id: 'art'

      response.should be_success
      assigns[:creators].should == creators
      assigns[:page].should == page
    end
  end

  context 'admin' do
    login_user

    describe "GET 'index'" do
      let!(:page){ create :page }
      let(:creators){ [mock] }

      before do
        Creator.should_receive(:by_category).with('art').and_return(creators)
        creators.should_not_receive(:published)
        creators.stub_chain(:page, :per).and_return(creators)
      end

      it "returns http success" do
        get :show, category_id: 'art'

        response.should be_success
        assigns[:creators].should == creators
        assigns[:page].should == page
      end
    end
  end
end
