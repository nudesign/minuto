require 'spec_helper'

describe Page do
  it { should be_timestamped_document }
  it { should_have_a_valid_factory }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
end
