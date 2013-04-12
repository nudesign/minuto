require 'spec_helper'

describe Mongoid::LolFinder do
  class Fighter
    include Mongoid::Document
    include Mongoid::LolFinder

    field :name
    field :coach_name
    field :location

    find_for :name, :coach_name
  end

  before do
    Fighter.create(name: 'Rocky Balboa', coach_name: 'Apollo Creed', location: 'Las Vegas')
    Fighter.create(name: 'Apollo Creed', location: 'Nevada')
  end

  describe '.find_for' do
    it { Fighter.should be_respond_to(:find_for) }
  end

  describe '.search' do
    context 'single search' do
      it { Fighter.search('creed').should have(2).item }
      it { Fighter.search('rocky').should have(1).item }
      it { Fighter.search('balboa').should have(1).item }
      it { Fighter.search('nevada').should have(0).item }
    end

    context 'composed search' do
      xit { Fighter.search('rocky nevada').should have(1).item }
    end
  end
end
