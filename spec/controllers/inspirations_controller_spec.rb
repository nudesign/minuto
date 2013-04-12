require 'spec_helper'

describe InspirationsController do
  describe "GET 'index" do
    let(:highlight) { mock_model(Inspiration, id: 1, highlight: true) }

    before do
      stub(:user_signed_in?) { false }
      Instagram.stub(:user_recent_media) { [] }
      Page.stub_chain(:find_for, :first) { mock_model(Page) }
    end

    it "returns inspirations without highlight" do
      inspiration = mock_model(Inspiration)

      Inspiration.stub(:first_highlight) { highlight }
      Inspiration.stub_chain(:list, :without_highlight) { [inspiration] }

      get :index

      expect(assigns(:highlight)).to eq(highlight)
      expect(assigns(:inspirations)).to eq([inspiration])
    end
  end



  it_should_behave_like "CRUD GET show",    :inspiration

  context 'admin' do
    login_user

    it_should_behave_like "CRUD GET new",     :inspiration
    it_should_behave_like "CRUD POST create", :inspiration
    it_should_behave_like "CRUD GET edit",    :inspiration
    it_should_behave_like "CRUD PUT update",  :inspiration
    it_should_behave_like "CRUD GET destroy", :inspiration
  end

  describe "GET 'by_tag'" do
    let(:tag) { "design" }
    let(:inspiration) { mock_model(Inspiration) }

    before do
      Inspiration.should_receive(:tagged_with).with(tag).and_return([inspiration])
    end

    it "returns inspirations filtered by tag" do
      get :by_tag, query: tag

      response.should be_success
      assigns(:inspirations).should eq([inspiration])
    end
  end
end