# frozen_string_literal: true

class AddImageAndNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :image_url, :string
  end
end
