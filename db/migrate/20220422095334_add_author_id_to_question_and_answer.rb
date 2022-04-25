# frozen_string_literal: true

class AddAuthorIdToQuestionAndAnswer < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :author, index: true, foreign_key: { to_table: :users }
    add_reference :answers, :author, index: true, foreign_key: { to_table: :users }
  end
end
