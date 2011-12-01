class UpdateAggregateAttributes < ActiveRecord::Migration
  def up
    Snapshot.reset_column_information
    Snapshot.find(:all).each { |snap| snap.update_aggregate_attributes }
  end

  def down
  end
end
