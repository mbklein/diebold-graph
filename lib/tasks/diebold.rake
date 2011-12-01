namespace :diebold do
  
  desc "Take a snapshot"
  task :snapshot, [:election_id] => [:environment] do |t, args|
    Presentation.snapshot(args[:election_id])
  end
  
end
