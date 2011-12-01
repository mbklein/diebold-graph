class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.integer :presentation_id
      t.datetime :at
      t.integer :score

      t.timestamps
    end
  end
end
