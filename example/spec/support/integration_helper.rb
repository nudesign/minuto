# encoding: UTF-8
module IntegrationHelpers
  def fill_a_new_creator
    fill_in "Nome", with: "Rocky Balboa"
    fill_in "Localização", with: "Califa"
    fill_in "O que faz", with: "lutador"
    fill_in "Release", with: "um texto curto"
    fill_in "Entrevista", with: "um texto um pouco maior"
    choose "creator_main_category_art"

    click_link("próximo passo")
  end

  def change_some_creator_informations
    fill_in "Nome", with: "Appolo Creed"
    choose "creator_main_category_art"
  end

  def creator_with_a_new_gallery
    visit creators_path
    click_link('be a creator!')
    fill_a_new_creator
    click_link("+ criar novo")
  end

  def create_gallery
    fill_in "Título", with: 'Rocky IV Photos'
    click_button("save")

    page.should have_content(I18n.t('flash.actions.create.notice', resource_name: Gallery.model_name.human))
  end

  def admin_sign_in
    user = create :user
    visit publisher_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: '1234567'
    click_button('entrar')

    page.should have_content('Login efetuado com sucesso!')
  end
end
