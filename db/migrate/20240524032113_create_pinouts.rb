# frozen_string_literal: true

class CreatePinouts < ActiveRecord::Migration[7.1]
  def change
    create_table :pinouts do |t|
      t.references :device, null: false, foreign_key: true
      t.text :mapping

      t.timestamps
    end
  end
end
