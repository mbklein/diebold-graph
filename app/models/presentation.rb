class Presentation < ActiveRecord::Base
  has_many :snapshots

  @@client = RestClient::Resource.new("http://vote.code4lib.org/election/results/")
  def self.snapshot(election_id)
    results = JSON.parse(@@client[election_id].get({:accept => :json}))
    snap_time = Time.now
    snap_time = (snap_time - snap_time.sec).to_i
    new_snapshots = []
    results.each do |result|
      pres = Presentation.find_or_create_by_id(result['id'])
      if pres.election_id.nil?
        pres.update_attributes :election_id => election_id, :title => result['title'], :description => result['description']
      end
      new_snapshots << pres.snapshots.create(:at_i => snap_time, :score => result['score'], :election_id => election_id)
    end
    new_snapshots.each { |snap| snap.update_aggregate_attributes }
  end
  
  def score_at(dt)
    snap = snapshots.select { |snap| snap.at <= dt }.last
    snap ? snap.score : 0
  end
  
  def series(attribute = :score)
    { 
      :name => self.title.strip, 
      :data => self.snapshots.collect { |snap|
        [snap.at_i * 1000, snap.send(attribute) ]
      }
    }
  end
  
end
