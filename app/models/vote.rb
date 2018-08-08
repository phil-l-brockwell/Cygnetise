# frozen_string_literal: true

class Vote < ApplicationRecord
  VALIDITY_OPTIONS = %w[during pre post].freeze

  belongs_to :campaign
  validates :validity, inclusion: { in: VALIDITY_OPTIONS }

  scope :valid, -> { where(validity: :during) }
  scope :invalid, -> { where.not(validity: :during) }
end
