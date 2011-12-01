class AddSnapshotAggregates < ActiveRecord::Migration
  def up
    add_column(:snapshots, :deviation_from_median, :integer)
    add_column(:snapshots, :deviation_from_mean, :integer)
    add_column(:snapshots, :percentage_of_max, :float)
    Snapshot.find(:all).each { |snap| snap.update_aggregate_attributes }
  end
  
  def down
    remove_column(:snapshots, :deviation_from_median)
    remove_column(:snapshots, :deviation_from_mean)
    remove_column(:snapshots, :percentage_of_max)
  end
end
