# frozen_string_literal: true

class Vote < ApplicationRecord
  VALIDITY_OPTIONS = %w[during pre post].freeze

  belongs_to :campaign
  validates :validity, inclusion: { in: VALIDITY_OPTIONS }
end
