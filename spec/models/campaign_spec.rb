# frozen_string_literal: true

require 'rails_helper'

describe Campaign do
  describe 'validations' do
    context 'title' do
      subject { FactoryBot.build(:campaign) }

      it 'is valid with a title' do
        expect(subject).to be_valid
      end

      it 'is invalid without a title' do
        subject.title = nil
        expect(subject).not_to be_valid
      end
    end
  end

  describe '.with_valid_votes' do
    let(:valid_campaign) { FactoryBot.create(:campaign) }
    let!(:valid_vote) { FactoryBot.create(:vote, campaign: valid_campaign) }
    let(:invalid_campaign) { FactoryBot.create(:campaign) }
    let!(:invalid_vote) { FactoryBot.create(:vote, :invalid, campaign: invalid_campaign) }

    it 'returns just the campaigns with valid votes' do
      expect(described_class.with_valid_votes).to include(valid_campaign)
      expect(described_class.with_valid_votes).not_to include(invalid_campaign)
    end
  end

  describe '#valid_votes_grouped_by_choice_with_counts' do
    subject { FactoryBot.build(:campaign) }
    let(:votes) { subject.valid_votes_grouped_by_choice_with_counts }

    before do
      2.times { FactoryBot.create(:vote, campaign: subject) }
      2.times { FactoryBot.create(:vote, campaign: subject, choice: 'Batman') }
      2.times { FactoryBot.create(:vote, :invalid, campaign: subject, choice: 'Superman') }
    end

    it 'returns the valid_votes_grouped_by_choice_with_counts' do
      expect(votes['Batman']).to eq(2)
      expect(votes['Spiderman']).to eq(2)
      expect(votes['Superman']).to eq(nil)
    end
  end
end
