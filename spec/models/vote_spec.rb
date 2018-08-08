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
end
