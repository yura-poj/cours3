# frozen_string_literal: true

class CreateAuthorizations < ActiveRecord::Migration[7.0]
  def change
    create_table :authorizations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider, index: true
      t.string :uid, index: true

      t.timestamps
    end
  end
end
