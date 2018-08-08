# frozen_string_literal: true

class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.string :validity
      t.string :choice

      t.timestamps
    end
  end
end
