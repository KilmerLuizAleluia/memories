# frozen_string_literal: true

class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
      t.string :description
      t.datetime :date
      t.string :weather
      t.string :local
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
