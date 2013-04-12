# encoding: UTF-8
require 'spec_helper'

describe "the creator gallery" do
  context 'logged as admin' do

    before do
      admin_sign_in
      creator_with_a_new_gallery
    end

    context 'see the actions', js: true do
      xit 'see some admin actions' do
        within('.actions') do
          page.should have_content('não aprovado')
          page.should have_content('rascunho')
          page.should have_content('publicado')
          page.should have_content('Data de publicação')
        end
      end
    end

    context 'creating a new gallery', js: true do
      let(:creator){ Creator.last }

      xit 'more than one gallery can be created' do
        create_gallery
        visit edit_creator_path(creator)

        page.should have_content('+ criar novo')
      end
    end
  end

  context 'without a creator' do
    context 'editing a gallery' do
      let(:creator){ create :creator }
      let(:gallery){ create :gallery, creator: creator }

      it 'cannot edit a normal gallery' do
        visit edit_creator_gallery_path(gallery.creator, gallery)
        page.current_path.should == new_user_session_path
      end
    end
  end

  context 'with a creator', js: true do
    before do
      creator_with_a_new_gallery
    end

    context 'see the actions' do
      it 'do not see some actions' do
        within('.actions') do
          page.should_not have_content('não aprovado')
          page.should_not have_content('rascunho')
          page.should_not have_content('publicado')
          page.should_not have_content('Data de publicação')
        end
      end
    end

    context 'creating a new gallery' do
      let(:creator){ Creator.last }

      it 'post the informations' do
        fill_in "Título", with: 'Rocky IV Photos'
        click_button("salvar")

        page.should have_content(I18n.t('flash.actions.create.notice', resource_name: Gallery.model_name.human))
      end

      xit 'only one gallery can be sent' do
        create_gallery
        visit edit_creator_path(creator)

        page.should_not have_content('+ criar novo')
      end
    end

    context 'editing a gallery' do
      let(:creator){ create :creator }
      let(:gallery){ create :gallery, creator: creator }

      xit 'cannot edit a normal gallery' do
        expect {
          visit edit_creator_gallery_path(gallery.creator, gallery)
        }.to raise_error(Mongoid::Errors::DocumentNotFound)
      end

      it 'can edit my gallery' do
        create_gallery

        fill_in "Título", with: 'Appolo Photos'
        click_button("salvar")

        page.should have_content(I18n.t('flash.actions.update.notice', resource_name: Gallery.model_name.human))
      end
    end

    context 'sending my portfolio' do
      let(:creator){ Creator.last }

      xit 'cannot edit my gallery, when it was already sent' do
        create_gallery

        visit edit_creator_path(creator)
        click_link('enviar portfolio')

        visit edit_creator_path(creator)
        page.current_path.should == new_user_session_path
      end
    end
  end
end
