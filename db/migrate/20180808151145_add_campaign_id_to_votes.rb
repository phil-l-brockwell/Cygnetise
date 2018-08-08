# frozen_string_literal: true

class AddCampaignIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :campaign_id, :integer
    add_index :votes, :campaign_id
  end
end
