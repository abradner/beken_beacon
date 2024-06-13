# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices do |t|
      t.integer :mac
      t.string :alias
      t.string :address

      t.timestamps
    end
  end
end
