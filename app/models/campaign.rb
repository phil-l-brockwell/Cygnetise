# frozen_string_literal: true

class Campaign < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  scope :with_valid_votes, -> { joins(:votes).merge(Vote.valid).uniq }

  def valid_votes_grouped_by_choice_with_counts
    votes.valid.group(:choice).count
  end
end
