require 'spec_helper'

describe PagesController do
  context 'admin' do
    login_user

    it_should_behave_like "CRUD GET edit",    :page
    it_should_behave_like "CRUD POST create", :page

    describe "should redirect to right resource" do
      it_should_behave_like "CRUD PUT update",  :page, :creator
      it_should_behave_like "CRUD GET destroy", :page, :creator
    end

    describe "GET new" do
      let!(:page){ create :page }

      before { get :new, id: :demo }

      it { response.should render_template :new }
      it { assigns[:page].should be_an_instance_of(Page) }
      it { assigns[:page].type.should == "demo" }
    end
  end
end
