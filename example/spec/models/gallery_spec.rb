require 'spec_helper'

describe Gallery do
  it { should be_timestamped_document }
  it { should_have_a_valid_factory }

  it { should validate_presence_of :title }

  it { should belong_to :creator }

  describe 'initialize' do
    context 'state published' do
      context 'without a published_at' do
        let(:creator){ build(:creator, state: :published) }
        before { creator.valid? }

        it { creator.published_at.should == Date.today }
      end

      context 'with a published_at' do
        let(:creator){ build(:creator, state: :published, published_at: 10.days.from_now) }
        before { creator.valid? }

        it { creator.published_at.should == 10.days.from_now.to_date }
      end
    end

    context 'another state' do
      let(:creator){ build(:creator, state: [:unapproved, :draft].sample) }
      before { creator.valid?  }

      it { creator.published_at.should be_nil }
    end
  end

  describe 'default_scope' do
    let!(:gallery){ create :gallery }
    let!(:new_gallery){
      Timecop.freeze(1.day.from_now) do
        create(:gallery)
      end
    }

    it 'sort by newest' do
      Gallery.all.to_a.should == [new_gallery, gallery]
     end
  end
end
