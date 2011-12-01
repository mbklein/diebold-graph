class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.integer :election_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
