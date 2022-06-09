class AddBestAnswerAndRewardToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :reward, null: true
    add_reference :answers, :best_answer
  end
end
