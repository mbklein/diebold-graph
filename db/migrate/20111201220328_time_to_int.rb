class TimeToInt < ActiveRecord::Migration
  def up
    add_column(:snapshots, :at_i, :integer)
    begin
      add_index(:snapshots, [:election_id, :at_i])
      remove_index(:snapshots, [:election_id, :at])
    rescue
    end
    Snapshot.find(:all).each { |snap| snap.update_attribute :at_i, snap.at.to_i }
    remove_column(:snapshots, :at)
  end

  def down
    add_column(:snapshots, :at, :datetime)
    begin
      add_index(:snapshots, [:election_id, :at])
      remove_index(:snapshots, [:election_id, :at_i])
    rescue
    end
    Snapshot.find(:all).each { |snap| snap.update_attribute :at, Time.at(snap.at_i) }
    remove_column(:snapshots, :at_i)
  end
end
