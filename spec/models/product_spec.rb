require 'spec_helper'

describe Product do
  it { should validate_presence_of :name }
  it { should respond_to(:store_name) }
  it { should respond_to(:store_link) }
  it { should respond_to(:price) }
  it { should respond_to(:size) }
  it { should respond_to(:main_category) }
  it { should respond_to(:categories) }
  it { should respond_to(:mine) }
  
end
