# encoding: UTF-8
require 'spec_helper'

describe "be a creator" do
  before do
    visit creators_path
  end

  context 'see the actions' do
    it 'do not see some actions' do
      click_link('be a creator!')

      within('.actions') do
        page.should have_link('próximo passo')
        page.should_not have_content('rascunho')
        page.should_not have_content('publicado')
        page.should_not have_content('Data de Publicação')
      end
    end
  end

  context 'creating a new creator', js: true do
    it 'post the informations' do
      click_link('be a creator!')
      fill_a_new_creator

      page.should have_content("Creator criado com sucesso. Já é possível criar uma galeria.")
    end
  end

  context 'editing a creator' do
    let(:creator){ create :creator }

    it 'cannot edit a normal creator' do
      visit edit_creator_path(creator)
      page.current_path.should == new_user_session_path
    end

    xit 'can edit my portfolio', js: true do
      click_link('be a creator!')
      fill_a_new_creator
      change_some_creator_informations
      visit current_path

      find_field('Nome').value.should eq("Appolo Creed")
    end
  end

  context 'sending my portfolio', js: true do
    let(:creator){ Creator.last }

    it 'can send my portfolio' do
      click_link('be a creator!')
      fill_a_new_creator
      click_link('enviar portfolio')

      page.should have_content("Seu portfolio foi enviado com sucesso.")
    end

    xit 'cannot edit my portfolio, when it was already sent', js: true do
      click_link('be a creator!')
      fill_a_new_creator
      click_link('enviar portfolio')

      visit edit_creator_path(creator)
      page.current_path.should == new_user_session_path
    end
  end
end
