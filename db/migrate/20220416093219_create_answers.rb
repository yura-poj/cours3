# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
