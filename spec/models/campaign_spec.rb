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
end
