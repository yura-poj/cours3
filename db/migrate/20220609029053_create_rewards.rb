# frozen_string_literal: true

class CreateRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :rewards do |t|
      t.string :title
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
