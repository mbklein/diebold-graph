class AddElectionIdToSnapshot < ActiveRecord::Migration
  def change
    add_column(:snapshots, :election_id, :integer)
    Snapshot.find(:all).each { |snap|
      snap.update_attribute :election_id, snap.presentation.election_id
    }
  end
end
