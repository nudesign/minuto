require 'spec_helper'

describe MinesController do
  # it_should_behave_like "CRUD GET index",   :mine
  it_should_behave_like "CRUD GET show",    :mine

  context 'admin' do
    login_user

    it_should_behave_like "CRUD GET new",     :mine
    it_should_behave_like "CRUD POST create", :mine
    it_should_behave_like "CRUD GET edit",    :mine
    it_should_behave_like "CRUD PUT update",  :mine
  end

end
