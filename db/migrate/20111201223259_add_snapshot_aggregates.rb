class AddSnapshotAggregates < ActiveRecord::Migration
  def change
    add_column(:snapshots, :deviation_from_median, :integer)
    add_column(:snapshots, :deviation_from_mean, :integer)
    add_column(:snapshots, :percentage_of_max, :float)
    Snapshot.find(:all).each { |snap| snap.update_aggregate_attributes }
  end
end
