# frozen_string_literal: true

class Campaign < ApplicationRecord
  has_many :votes

  validates :title, presence: true
end
