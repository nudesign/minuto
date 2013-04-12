require 'spec_helper'

describe GalleriesController do

  describe "GET new" do
    let(:creator){ create :creator }

    before do
      session[:creator_id] = creator.to_param
    end

    context 'creator without a gallery' do
      it "renders the form to create a new gallery" do
        get :new, creator_id: creator.to_param

        response.should render_template :new
        assigns[:gallery].should be_an_instance_of(Gallery)
      end
    end

    context 'creator with a gallery' do
      before do
        create :gallery, creator: creator
      end

      it "redirect to edit creator path" do
        get :new, creator_id: creator.to_param
        response.should redirect_to edit_creator_path(creator)
      end
    end
  end

  context 'admin' do
    login_user

    describe "GET new" do
      let(:creator){ create :creator }

      before do
        session[:creator_id] = creator.to_param
      end

      context 'creator without a gallery' do
        it "renders the form to create a new gallery" do
          get :new, creator_id: creator.to_param

          response.should render_template :new
          assigns[:gallery].should be_an_instance_of(Gallery)
        end
      end

      context 'creator with a gallery' do
        before do
          create :gallery, creator: creator
        end

        it "do not redirect" do
          get :new, creator_id: creator.to_param

          response.should render_template :new
          assigns[:gallery].should be_an_instance_of(Gallery)
        end
      end
    end

    it_should_behave_like "NESTED CRUD GET show",    :gallery, :creator
    it_should_behave_like "NESTED CRUD POST create", :gallery, :creator
    it_should_behave_like "NESTED CRUD GET edit",    :gallery, :creator
    it_should_behave_like "NESTED CRUD PUT update",  :gallery, :creator
    it_should_behave_like "NESTED CRUD GET destroy", :gallery, :creator
  end
end
