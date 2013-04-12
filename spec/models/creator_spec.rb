require 'spec_helper'

describe Creator do
  it { should be_timestamped_document }
  it { should_have_a_valid_factory }
  it { should have_many :galleries }

  describe 'steps' do
    context 'first' do
      let(:creator){ build :blank_creator, step: :first_step }

      it { creator.should be_valid }
    end

    context 'second' do
      let(:creator){ build :blank_creator, step: :second_step }

      it { creator.should_not be_valid }
      it { creator.should have(1).error_on(:name) }
      it { creator.should have(1).error_on(:location) }
      it { creator.should have(1).error_on(:occupation) }
      it { creator.should have(1).error_on(:release) }
      it { creator.should have(1).error_on(:interview) }
      it { creator.should have(1).error_on(:main_category) }
    end

    context 'finished' do
      let(:creator){ build :blank_creator, step: :finished }

      it { creator.should_not be_valid }
      it { creator.should have(1).error_on(:name) }
      it { creator.should have(1).error_on(:location) }
      it { creator.should have(1).error_on(:occupation) }
      it { creator.should have(1).error_on(:release) }
      it { creator.should have(1).error_on(:interview) }
      it { creator.should have(1).error_on(:main_category) }
    end
  end

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

  describe 'delegating methods' do
    let(:creator) { build(:creator) }

    it { creator.should respond_to :galleries_published }
  end

  describe '.list' do
    context 'including drafts' do
      it 'returns criteria all' do
        expect(Creator.list(true).selector).to eq({})
      end
    end

    context 'not including drafts' do
      it 'returns criteria published' do
        published = Creator.published

        expect(Creator.list(false).selector).to eq(published.selector)
      end
    end
  end

  describe '.newest' do
    context 'published creators' do
      let!(:design){ create :creator, main_category: "design" }
      let!(:fashion){ create :creator, main_category: "fashion" }
      let!(:architecture){ create :creator, main_category: "architecture" }
      let!(:art){
        Timecop.freeze(2.minutes.ago) do
          create :creator, main_category: "art", created_at: 2.minutes.ago
        end
      }

      let!(:old_design){
        Timecop.freeze(1.minute.ago) do
          create :creator, main_category: "design", created_at: 1.minute.ago
        end
      }

      subject { Creator.newest }

      it { should == [art, architecture, design, fashion, old_design] }

      context 'with a new creator' do
        let!(:new_art){
          Timecop.freeze(1.day.from_now) do
            create :creator, main_category: "art", published_at: 1.day.ago
          end
        }

        xit { should == [new_art, architecture, design, fashion, old_design, art] }
      end
    end

    context 'unpublished creator' do
      before do
        create :creator, main_category: "design", state: [:unapproved, :draft].sample
        create :creator, main_category: "fashion", state: [:unapproved, :draft].sample
        create :creator, main_category: "architecture", state: [:unapproved, :draft].sample
      end

      it { Creator.newest.should be_empty }
    end
  end

  describe ".by_category" do
    before do
      create :creator, main_category: "fashion", categories: ["design"]
      create :creator, main_category: "art", categories: ["design"]
    end

    it { Creator.by_category("design").should have(2).item }
    it { Creator.by_category("fashion").should have(1).item }
    it { Creator.by_category("art").should have(1).item }
    it { Creator.by_category("wrong_category").should have(0).item }
  end

  describe '#have_gallery_with_photo?' do
    let(:creator){ create :creator }
    subject { creator.have_gallery_with_photos? }

    context 'without a gallery' do
      before { creator.stub!(:galleries).and_return([]) }

      it { should be_false }
    end

    context 'with a gallery without photos' do
      let(:gallery){ mock(photos?: false) }
      before { creator.stub!(:galleries).and_return([gallery]) }

      it { should be_false }
    end

    context 'with a gallery with photos' do
      let(:gallery){ mock(photos?: true) }
      before { creator.stub!(:galleries).and_return([gallery]) }

      it { should be_true }
    end
  end

  describe '#cover_gallery_photo' do
    xit
  end
end
