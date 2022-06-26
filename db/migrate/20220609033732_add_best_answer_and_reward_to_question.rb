# frozen_string_literal: true

class AddBestAnswerAndRewardToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :reward, null: true
    add_reference :questions, :best_answer, null: true,
                                            foreign_key: { to_table: :answers }
  end
end
