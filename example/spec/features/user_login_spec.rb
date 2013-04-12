require "spec_helper"

describe "authentication" do
  let(:user) { create(:user, :password => "123456", :password_confirmation => "123456") }

  describe "logging" do
    it "should login with valid credentials" do
      visit publisher_path
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => "123456"
      click_button "entrar"

      page.should have_content("logout")
    end
  end

  describe "logging out" do
    it "should logout" do
      visit publisher_path
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => "123456"
      click_button "entrar"
      click_link "logout"

      page.should_not have_content("logout")
    end
  end
end