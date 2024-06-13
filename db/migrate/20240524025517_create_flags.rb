# frozen_string_literal: true

class CreateFlags < ActiveRecord::Migration[7.1]
  def change
    create_table :flags do |t|
      t.references :device, null: false, foreign_key: true
      t.integer :mask

      t.timestamps
    end
  end
end
