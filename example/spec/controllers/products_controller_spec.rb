require 'spec_helper'

describe ProductsController do

  context 'admin' do
    login_user

    it_should_behave_like "NESTED CRUD POST create", :product, :mine
    it_should_behave_like "NESTED CRUD GET edit",    :product, :mine
    it_should_behave_like "NESTED CRUD PUT update",  :product, :mine
    it_should_behave_like "NESTED CRUD GET destroy embeds many", :product, :mine

  end

end
