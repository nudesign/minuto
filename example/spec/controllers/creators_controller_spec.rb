# encoding: UTF-8
require 'spec_helper'

describe CreatorsController do
  it_should_behave_like "CRUD GET index",   :creator
  it_should_behave_like "CRUD GET new",     :creator
  it_should_behave_like "CRUD POST create", :creator

  describe "GET portfolios" do
    it "fails to access portfolios not logged" do
      Creator.should_not_receive(:portfolios)

      get :portfolios
      response.should redirect_to new_user_session_path
    end
  end

  describe "GET step2" do
    context 'with valid data' do
      let(:creator){ create :creator }

      before do
        session[:creator_id] = creator.id
      end

      it 'redirect to edit creator with a success message' do
        get :step2, id: creator.to_param

        response.should redirect_to edit_creator_path(creator)
        flash[:notice].should eq("Creator criado com sucesso. Já é possível criar uma galeria.")
      end
    end

    context 'with invalid data' do
      let(:creator){ create :blank_creator }

      before do
        session[:creator_id] = creator.id
      end

      it 'fails change creator to the next step' do
        get :step2, id: creator.to_param

        response.should render_template :edit
        flash[:notice].should be_nil
      end
    end
  end

  describe "GET show" do
    let(:creator){ create :creator }

    context 'published creator' do
      it 'show a specific creator' do
        get :show, id: creator.to_param

        response.should render_template :show
        assigns[:creator].should == creator
      end
    end

    context 'draft creator' do
      let(:creator){ create :draft_creator }

      it 'show a specific creator' do
        get :show, id: creator.to_param

        response.should redirect_to creators_path
        flash[:notice].should == "O creator #{creator.name} ainda não foi aprovado. Em breve esta página estará disponível."
      end
    end
  end

  describe "POST send" do
    let(:creator){ create :creator, state: :unapproved }

    before do
      session[:creator_id] = creator.id
    end

    it 'send a creator portfolio' do
      post :send_portfolio

      response.should redirect_to creators_path
      flash[:notice].should == "Seu portfolio foi enviado com sucesso."
    end
  end

  context 'admin' do
    login_user

    describe "GET portfolios" do
      it "see a list of portfolios" do
        Creator.should_receive(:portfolios)

        get :portfolios
      end

      it "using index view" do
        get :portfolios

        response.should render_template(:index)
      end
    end

    describe "GET show" do
      context 'published creator' do
        let(:creator){ create :creator }

        it 'show a specific creator' do
          get :show, id: creator.to_param

          response.should render_template :show
          assigns[:creator].should == creator
        end
      end

      context 'draft creator' do
        let(:creator){ create :draft_creator }

        it 'show a specific creator' do
          get :show, id: creator.to_param

          response.should render_template :show
          assigns[:creator].should == creator
        end
      end
    end

    it_should_behave_like "CRUD GET edit",    :creator
    it_should_behave_like "CRUD PUT update",  :creator
    it_should_behave_like "CRUD GET destroy", :creator
  end
end
