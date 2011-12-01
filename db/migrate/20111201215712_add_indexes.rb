class AddIndexes < ActiveRecord::Migration
  def up
    add_index(:presentations, :election_id)
    add_index(:snapshots, :presentation_id)
    add_index(:snapshots, [:election_id, :at])
  end

  def down
    remove_index(:presentations, :election_id)
    remove_index(:snapshots, :presentation_id)
    remove_index(:snapshots, [:election_id, :at])
  end
end
