class CreateEarnedRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :earned_rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true

      t.timestamps
    end
  end
end
