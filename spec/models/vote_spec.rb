# frozen_string_literal: true

require 'rails_helper'

describe Vote do
  context 'validations' do
    subject { FactoryBot.build(:vote) }

    it 'is valid with a validity and campaign' do
      expect(subject).to be_valid
    end

    it 'is invalid without a campaign' do
      subject.campaign = nil
      expect(subject).not_to be_valid
    end

    context 'validity' do
      it 'is valid with the correct options' do
        described_class::VALIDITY_OPTIONS.each do |option|
          subject.validity = option
          expect(subject).to be_valid
        end
      end

      it 'is invalid with an incorrect option' do
        subject.validity = 'banana'
        expect(subject).not_to be_valid
      end
    end
  end

  context 'scopes' do
    let!(:valid_vote_1) { FactoryBot.create(:vote) }
    let!(:valid_vote_2) { FactoryBot.create(:vote) }
    let!(:invalid_vote_1) { FactoryBot.create(:vote, :invalid) }
    let!(:invalid_vote_2) { FactoryBot.create(:vote, :invalid) }

    context '.valid' do
      it 'returns just the valid votes' do
        expect(described_class.valid).to match_array([valid_vote_1, valid_vote_2])
      end
    end

    context '.invalid' do
      it 'returns just the invalid votes' do
        expect(described_class.invalid).to match_array([invalid_vote_1, invalid_vote_2])
      end
    end
  end
end
