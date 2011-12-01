namespace :diebold do
  
  desc "Take a snapshot"
  task :snapshot, [:election_id] => [:environment] do |t, args|
    Presentation.snapshot(args[:election_id])
  end
  
  desc "Normalize snapshots"
  task :normalize => :environment do |t|
    Snapshot.find(:all).each { |snap| snap.at = Time.at((snap.at - snap.at.sec).to_i); snap.save }
  end
  
end
