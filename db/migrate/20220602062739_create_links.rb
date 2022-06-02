class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url
      t.string :name
      t.references :question, foreign_key: true, index: true

      t.timestamps
    end
  end
end
